Return-Path: <dgibson@ozlabs.org>
Date: Thu, 17 Jul 2008 15:47:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] dtc: supply a definition for YYRHSLOC if there isn't one
Message-ID: <20080717054713.GF21564@yookeroo.seuss>
References: <1216230837-17557-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216230837-17557-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 01:53:57PM -0400, Paul Gortmaker wrote:
> It seems that some machines, like a default RHEL4 install, will
> not have a definition for YYRHSLOC, and that prevents building
> dtc.  This supplies what appears to be the standard definition
> for it in the event that the host system does not have it defined.

I'm pretty uneasy about this, since it relies on knowing the internals
of how bison manages its tokens.  What version of bison is it in RHEL4
that causes the trouble?

In fact I have a feeling that the extra 'file' field in YYLTYPE never
gets used, which means we could just ditch our custom YYLLOC_DEFAULT
definition, which would be a better idea, IMO, except that we'll
probably want the file info back at some point.

Ick.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
