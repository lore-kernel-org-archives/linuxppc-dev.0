Date: Sun, 5 Jan 2003 20:22:02 -0700
From: Matt Porter <porter@cox.net>
To: Claudia Salzberg <sentinel@jump.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mapping back to 36 bit physical
Message-ID: <20030105202202.A22675@home.com>
References: <Pine.LNX.4.33.0212181358270.23138-100000@grandmaster.protagonist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.33.0212181358270.23138-100000@grandmaster.protagonist.org>; from sentinel@jump.net on Wed, Dec 18, 2002 at 02:07:45PM +0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 18, 2002 at 02:07:45PM +0600, Claudia Salzberg wrote:
>
> Greetings.
> How does one go about aquiring the 36-bit physical address on a 440XX if
> you have the corresponding va from an ioremap (when your driver is not
> the one that did the ioremap so that you don't have the pa saved)?  I see
> that ioremap does support 36-bit I/O mapping but _va and _pa only play
> with unsigned long's.  So does iopa.  So do the virt_to_* 's I was able
> to find.  Also, does anyone have plans for incorporating memory access
> hooks above 4GB address space?

Everything is in the linuxppc-2.5 and linuxppc_2_4_devel to support all
normal kernel functionality with the exception of remap_page_range().
As part of a recent checkin, the commit notice gave a reference to an
ftp site to get a remap_page_range() 64-bit patch.  Check your changesets
or linuxppc-commit list archives.

You need to save the pa.  virt_to_* and friends are only valid for
kernel lowmem addresses as per Documentation/IO-mapping.txt.  Regardless,
all new drivers should be using the dma mapping api and saving the pa
as required.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
