Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96EC4B7C06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 10:29:36 +1000 (EST)
Message-ID: <52426.84.105.60.153.1254184171.squirrel@gate.crashing.org>
In-Reply-To: <20090928192454.4dc937c9@lappy.seanm.ca>
References: <20090925165411.6c584401@lappy.seanm.ca>
	<20090928013654.466c9b72@opus.seanm.ca>
	<20090928115316.7e0b7db9@lappy.seanm.ca>
	<903BCD86-DE53-48AB-89CF-78248D7F6115@kernel.crashing.org>
	<20090928192454.4dc937c9@lappy.seanm.ca>
Date: Tue, 29 Sep 2009 02:29:31 +0200 (CEST)
Subject: Re: warning: allocated section `.data_nosave'  not in segment
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Sean MacLennan" <smaclennan@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Here is the ld -M output for the "bad" compile:
>
> .data_nosave    0xc0376790      0x870 load address 0x00376790
>                 0xc0377000                . = ALIGN (0x1000)
>  *fill*         0xc0376790      0x870 00

Ah right.  Having the ALIGN() inside the output section causes the linker
to put some filler in there, which makes it a non-empty section, but this
section isn't assigned to a segment so you get a warning from the linker.

I think the proper way to do this is to not put the ALIGN() before the
output section, nor inside it, but _on_ it, like

.data_nosave : ALIGN(0x1000) { .... }


Segher
