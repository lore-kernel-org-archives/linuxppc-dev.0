Message-ID: <3AB7FFF6.EB575041@mvista.com>
Date: Tue, 20 Mar 2001 20:12:22 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: nunninger@web.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: strange problem while booting
References: <3AB7E349.8AC5A1B0@enst.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nunninger wrote:

>  loaded at:     00100000 00100000

You have to load the bits into memory at or above 0x200000...NO, don't
change anything in the Makefile, just load the resulting bits like
this.  The zImage decompressor has to relocate itself to 0x100000.
There
isn't any bss space allocated between the end of the data and the start
of the zImage/initrd in the downloaded image.  Your decompressor code is
likely writing over the images.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
