Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 88EACDDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jul 2008 12:30:00 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so958824anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Jul 2008 19:29:58 -0700 (PDT)
Message-ID: <fa686aa40807071929s3ba2a33cl5f6a411c89fc2132@mail.gmail.com>
Date: Mon, 7 Jul 2008 20:29:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
Subject: Re: booting an ML405
In-Reply-To: <4872C4D0.4060006@alphagolf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486D774A.7000102@alphagolf.com>
	<440abda90807031902u766eb4dby932e8741e947488e@mail.gmail.com>
	<4872C4D0.4060006@alphagolf.com>
Cc: David Baird <dhbaird@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 7:37 PM, Lorenzo T. Flores <lorenzo@alphagolf.com> wrote:
> David,
>
> Thanks for the response. I searched a little more and found that many people
> recommend looking through __log_buf to see if info is getting printed to
> memory. Below I've added the printouts I get both before and after the
> system hangs. Also, I'm not using Uartlite. I'm using 16550; however, I have
> created the same design with Uartlite and adjusted the console parameter to
> reflect that change. In both instances the kernel hangs. You're right too,
> this is common...I just need to figure out how to read out this __log_buf
> address:
>
> If I stop the processor after it hangs:

... This looks like ASCII text; let's try decoding it...

> XMD% mrd 0xc0259fa4 10
> C0259FA4:   3C353E5B    '<5>['
> C0259FA8:   20202020    '    '
> C0259FAC:   302E3030    '0.00'
> C0259FB0:   30303030    '0000'
> C0259FB4:   5D204C69    '] Li'
> C0259FB8:   6E757820    'nux '
> C0259FBC:   76657273    'vers'
> C0259FC0:   696F6E20    'ion '
> C0259FC4:   322E362E    '2.6.'
> C0259FC8:   32352D72    '25-r'

Looks like you've found how to read the logbuf; now you just need to
dump it to a file so tha tyou can read it.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
