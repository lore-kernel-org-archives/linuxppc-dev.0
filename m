Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Jul 2007 14:31:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/15] boot: simplfy gunzip_finish
Message-ID: <20070719043125.GA18321@localhost.localdomain>
References: <boot-6-00.miltonm@bga.com> <boot-6-03.miltonm@bga.com>
	<20070719023917.GF20458@localhost.localdomain>
	<323b556138e9e745eb4fc6327faf7774@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <323b556138e9e745eb4fc6327faf7774@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2007 at 11:01:37PM -0500, Milton Miller wrote:
> 
> On Jul 18, 2007, at 9:39 PM, David Gibson wrote:
> 
> > On Tue, Jul 10, 2007 at 05:08:32PM -0500, Milton Miller wrote:
> >>
> >> Call gunzip_partial to calculate the remaining length and copy the
> >> data to the user buffer.   This makes it shorter and reduces
> >> duplication.
> >>
> >> Signed-off-by: Milton Miller <miltonm@bga.com>
> >
> > Hrm... I guess this is sufficient.  Since we'll shortly be blowing
> > away the state anyway, the lack of call to inflateEnd doesn't really
> > matter.  Originally I was going to make this function call fatal() if
> > the destination didn't have enough space to contain the decompressed
> > tail of the image, but obviously I decided aginst that.
> >
> > But, if you're going to do this, you might as well get rid of
> > gunzip_finish() entirely, and have the callers using gunzip_partial
> > instead.
> 
> Huh?   I stilll call inflateEnd if s.workspace is not NULL, I just 
> don't duplicate gunzip_partial in gunzip_finish.  Calling inflateEnd 

Oh, yes, oops.  Missed the couple of lines there that didn't have a
'-' in front.

> will mean a future call would return an error in the compressed case 
> instead of the behavior in the non-compressed case that changes with 
> this patch from get same data again to get further data that may exist 
> after the patch.
> 
> Yes, one can argue that we don't need to call inflateEnd, but I didn't 
> make that change in this patch.
> 
> Or were you suggesting that we really don't need the finish function?

Well, we probably don't.  But for the time being.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
