Message-Id: <200007171653.SAA16824@denx.local.net>
To: ajay.kunnath@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help with MPC port 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Jul 2000 09:07:11 PDT."
             <21F9768AF088D211BF1C0008C71E5786011B7913@ap-bang-m02.india.tek.com>
Date: Mon, 17 Jul 2000 18:53:44 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <21F9768AF088D211BF1C0008C71E5786011B7913@ap-bang-m02.india.tek.com> you wrote:
>
> I noticed in the m8xx_tty.c that the first few lines of code try to
> access the structure immap_t. But, who initializes these structures ?
> Is it the EPPCbug of MBX ? If so, how do I go about doing similar
> thing on my proprietary board ?

It's the CPU who initializes this struc :-)

You see it's used like that: "((immap_t *)IMAP_ADDR)->..."; IMAP_ADDR
is the (physical) address where the IMMR of your CPU  is  mapped,  so
you're accessing hardware registers, not some data structures in RAM.

Welcome to the world of low level, hardware related programming!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bradley's Bromide: If computers get too  powerful,  we  can  organize
them into a committee - that will do them in.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
