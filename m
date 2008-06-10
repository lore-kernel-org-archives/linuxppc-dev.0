Return-Path: <scottwood@freescale.com>
Date: Tue, 10 Jun 2008 11:57:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Image generation for Efika is broken in 2.6.26
Message-ID: <20080610165719.GA5139@loki.buserror.net>
References: <9e4733910806100738rac8e415x99f6e96715ebee90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910806100738rac8e415x99f6e96715ebee90@mail.gmail.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2008 at 10:38:31AM -0400, Jon Smirl wrote:
> Why is my vmlinux.strip 3.2GB? Could a missing address be interpreted
> as -1 (0xFFF..) and cause the image to contain all of memory?
> 
> -rw-r--r--  1 jonsmirl jonsmirl   61738015 2008-06-10 10:31 vmlinux.o
> -rwxr-xr-x  1 jonsmirl jonsmirl 3224175192 2008-06-10 10:31 vmlinux.strip.3651
> 
> After it is packed vmlinux is 32MB. Packing gigabytes of zeros, maybe?
> 
> -rwxr-xr-x  1 jonsmirl jonsmirl 32430673 2008-06-10 10:31 vmlinux
> 
> This image won't load onto the Efika probably because it is trying to
> expand back to 3.2GB.
> 
> With the same .config vmlinux is 4.1MB on 2.6.25
> 
> -rwxr-xr-x  1 jonsmirl jonsmirl 4119174 2008-06-09 20:09 vmlinux

Are you using binutils 2.17?  It has a bug that was triggered by the p_paddr
change.  Do you get a bunch of warnings from the strip command?

-Scott
