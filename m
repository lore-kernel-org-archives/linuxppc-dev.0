Return-Path: <egoforth@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.205])
	by ozlabs.org (Postfix) with ESMTP id D7B10679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 04:20:34 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id r21so683396wxc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Feb 2006 09:20:33 -0800 (PST)
Message-ID: <75b39f010602200920x403312c7ye0088301602b7e23@mail.gmail.com>
Date: Mon, 20 Feb 2006 12:20:33 -0500
From: "Ed Goforth" <egoforth@gmail.com>
To: "Ed Goforth" <egoforth@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: 440gx GPIO
In-Reply-To: <20060214170140.GB12465@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43F168A3.4020808@gmail.com>
	<20060214065934.GA12465@gate.ebshome.net>
	<75b39f010602140548u18f30145tf2ddf529467b2605@mail.gmail.com>
	<20060214170140.GB12465@gate.ebshome.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 2/14/06, Eugene Surovegin <ebs@ebshome.net> wrote:
>
> Try writing the same GPIO output register value as you read from it
> (without clearing bit 11). Also, try changing some other GPIO bit
> (e.g. one which is not connected in your design). Maybe board hangs
> exactly because you set GPIO bit 11 low :).

Bingo!  The board wasn't actually hanging.  When we set GPIO11 low, it
is supposed to reset our on-board FPGAs.  One of the FPGAs controls a
TX disable signal.  And the (current) default on a reset is to leave
the TX disable low, hence no network after a FPGA reset.  Doesn't work
well with a NFS root :)


>
> Also, connect scope to that GPIO pin and see what is really going on.
>
> --
> Eugene
