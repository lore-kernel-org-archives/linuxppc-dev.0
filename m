Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Jul 2007 12:39:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/15] boot: simplfy gunzip_finish
Message-ID: <20070719023917.GF20458@localhost.localdomain>
References: <boot-6-00.miltonm@bga.com> <boot-6-03.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-6-03.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 05:08:32PM -0500, Milton Miller wrote:
> 
> Call gunzip_partial to calculate the remaining length and copy the
> data to the user buffer.   This makes it shorter and reduces
> duplication.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Hrm... I guess this is sufficient.  Since we'll shortly be blowing
away the state anyway, the lack of call to inflateEnd doesn't really
matter.  Originally I was going to make this function call fatal() if
the destination didn't have enough space to contain the decompressed
tail of the image, but obviously I decided aginst that.

But, if you're going to do this, you might as well get rid of
gunzip_finish() entirely, and have the callers using gunzip_partial
instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
