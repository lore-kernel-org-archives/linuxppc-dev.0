Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BFE4CB7C02
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 01:53:19 +1000 (EST)
Date: Mon, 28 Sep 2009 11:53:16 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: warning: allocated section `.data_nosave'  not in segment
Message-ID: <20090928115316.7e0b7db9@lappy.seanm.ca>
In-Reply-To: <20090928013654.466c9b72@opus.seanm.ca>
References: <20090925165411.6c584401@lappy.seanm.ca>
	<20090928013654.466c9b72@opus.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I looked into it some more.... the patch converts this section:

        . = ALIGN(PAGE_SIZE);
        .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
               __nosave_begin = .;
               *(.data.nosave)
               . = ALIGN(PAGE_SIZE);
               __nosave_end = .;
        }

to:

	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
		NOSAVE_DATA
	}

If you expand the NOSAVE_DATA macro, you get:

	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
		. = ALIGN(PAGE_SIZE);
		VMLINUX_SYMBOL(__nosave_begin) = .;
		*(.data.nosave)
		. = ALIGN(PAGE_SIZE);
		VMLINUX_SYMBOL(__nosave_end) = .;
	}

If you ignore the VMLINUX_SYMBOL, the only difference is moving the
ALIGN inside the brackets. If I move the ALIGN back where it was, then
the warning goes away.

But other sections moved the ALIGN without an issue. Could it be a
compiler problem? We are using  version 4.0.0 (DENX ELDK 4.1 4.0.0).

Cheers,
   Sean
