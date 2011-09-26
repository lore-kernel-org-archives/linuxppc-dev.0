Return-Path: <ittette@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 354F6B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 04:13:28 +1000 (EST)
Received: by qyk32 with SMTP id 32so9848767qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Sep 2011 11:13:25 -0700 (PDT)
MIME-Version: 1.0
Sender: ittette@gmail.com
In-Reply-To: <1317058016.1650.50.camel@pug>
References: <BLU124-W1648A42F7514E880C9B199B4F20@phx.gbl>
	<1317058016.1650.50.camel@pug>
Date: Mon, 26 Sep 2011 20:13:24 +0200
Message-ID: <CAC157GAaqdNVQf9hycEVft3cgpbVWxOwncBSNwfVFBGQugZjpQ@mail.gmail.com>
Subject: Re: Loading Linux from already running code..
From: Philipp Ittershagen <p.ittershagen@googlemail.com>
To: Carlos Munoz <cmunoz@sablenetworks.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Sumesh Kaana <sumeshkkn@hotmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 26, 2011 at 7:26 PM, Carlos Munoz <cmunoz@sablenetworks.com> wrote:
> You could build a tarball containing the root files system, dtb, Linux,
> plus a header indicating where the different pieces need to be loaded.
> Then your initial code loads the different parts at the right memory
> locations, sets up the Linux arguments, and jumps to Linux.

That is exactly what the firmware-independent simpleImage.initrd.*
targets already do. The resulting elf file include the dtb and initrd
as well as a prompt-like boot arg cli.
I think it will be possible to just place the simpleImage.initrd.*
into you memory and let the existing code jump to the start adress of
the elf image. I managed to start a ppc core using JTAG and the
simpleImage.initrd elf files and I think the procedure is very much
the same but instead of the JTAG debugger setting the PC to the start
address, your startup code has to do it.


Philipp
