Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF9B0B7BD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 06:55:42 +1000 (EST)
In-Reply-To: <20090928115316.7e0b7db9@lappy.seanm.ca>
References: <20090925165411.6c584401@lappy.seanm.ca>
	<20090928013654.466c9b72@opus.seanm.ca>
	<20090928115316.7e0b7db9@lappy.seanm.ca>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <903BCD86-DE53-48AB-89CF-78248D7F6115@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: warning: allocated section `.data_nosave'  not in segment
Date: Mon, 28 Sep 2009 22:56:42 +0200
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> If you ignore the VMLINUX_SYMBOL, the only difference is moving the
> ALIGN inside the brackets. If I move the ALIGN back where it was, then
> the warning goes away.
>
> But other sections moved the ALIGN without an issue. Could it be a
> compiler problem? We are using  version 4.0.0 (DENX ELDK 4.1 4.0.0).

The compiler version is probably not relevant; the binutils versions
might be though.  But, it seems to me the patch was simply botched,
the ALIGN() should not have moved.

Look at the output of "ld -M" (the ld command with all the args that
are used during the compile, with -M added) to see what's up; or maybe
readelf can tell you already.


Segher
