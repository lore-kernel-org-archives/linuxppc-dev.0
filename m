Message-ID: <410FD23C.2070506@rossvideo.com>
Date: Tue, 03 Aug 2004 13:58:20 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Daren Hayward <darenh@4bridgeworks.com>
Cc: "'Matt Porter'" <mporter@kernel.crashing.org>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: early UART mapping in head_44x.S
References: <C18BA5DDB58DD511BD0700C0DF0DD45011C475@NTSERVER4>
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD45011C475@NTSERVER4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daren Hayward wrote:
 > Hi,
 >
 > I have been having the same problems with the head_44x.S, what does
 > the patch do just remove the duplicate entries?
 >
 > Where can I browse the PPC BK tree online?

Hi Daren

I'm using mainline sources (eg. tarball from kernel.org)... its a
one-line fix for the TLB setup.. the second one should use slot 2
not slot 1 (which is already setup).  Note this only affects you if you
build with CONFIG_EARLY_SERIAL_DEBUG.

I just found your post to the u-boot mailing list from 2004-07-02 where
you mention networking problems unless you use u-boot to touch the
network somehow before the kernel boots.

I am seeing very much similar behaviour, with 2.6.7 kernel and using
PIBS bootloader.

Looks very much like the kernel is missing some initialization that is
required.  Did you make any progress tracking down the cause?

-Ralph

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
