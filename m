Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 9428B2BDB6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 01:45:46 +1000 (EST)
Date: Fri, 8 Oct 2004 11:38:12 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <11BB7E60-193F-11D9-9299-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0410081124070.13521@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<11BB7E60-193F-11D9-9299-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 8 Oct 2004, Dan Malek wrote:

> Once again I'll add the observation that people using these 
> processors have to know how the boards are configured and to select 
> the proper options.  There is lots of variation among the 
> configurations and I'd rather not build complex configuration menus 
> that try to keep users from hurting themselves.  The default 
> configuration files are there for a reason, let's use them to assist 
> people (and keep them up to date).

i have no problem with that.  my point was that what are currently 
potentially confusing config menus should be made *simpler*.  i wasn't 
even talking about putting smarts into the config menus to keep people 
from hurting themselves.  i was only talking about putting what 
appeared to be tightly-related config options closer to one another so 
one did not have to bounce from one place to another in the config 
menus to select or deselect related features, that's all.  not a big 
deal for me, it was just an observation.

> If you are making changes to configuration options, it would be nice 
> if you would also at least regenerate all default configuration 
> files affected by this (as I do).  At least make an honest attempt 
> at getting it correct.

been there, done that, thanks.  all of the microcode patch code that 
i've submitted is based on a user selecting that they want *some* 
patch, which is reflected by the config variable CONFIG_UCODE_PATCH.
for all default config files that refer to this variable, they *all* 
contain the line:

# CONFIG_UCODE_PATCH is not set

in short, none of the default config files need to be changed -- they 
will all initially show a config menu with no selected patch.

(what *won't*, of course, be in these default config files is the set 
of option lines for each possible patch, like:

# CONFIG_I2C_SPI_UCODE_PATCH is not set
...
and so on.  but that doesn't matter, since the first time you 
configure and save, they'll be generated.  in short, the default 
config files appear to be just fine.)

rday

p.s.  ironically, i recall just yesterday suggesting that 
soon-to-be-deleted config variables should be removed from those very 
config files, and i was told to just leave them alone.  one does get 
mixed messages on this list sometimes, don't one? :-)
