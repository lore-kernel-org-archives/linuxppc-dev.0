Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.183])
	by ozlabs.org (Postfix) with ESMTP id E429CDDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 06:07:41 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so203028ele
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Nov 2007 12:07:39 -0700 (PDT)
Message-ID: <fa686aa40711011207l5812bb71le3ead34545c2f4d1@mail.gmail.com>
Date: Thu, 1 Nov 2007 13:07:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Mead, Joseph" <mead@bnl.gov>
Subject: Re:
In-Reply-To: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC59788F@exchangemb3.bnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC59788F@exchangemb3.bnl.gov>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/1/07, Mead, Joseph <mead@bnl.gov> wrote:
>
>
>
>
> I am using a Xilinx ML403 board and created a custom IP that connects to =
the
> PLB bus.   The PLB bus is 64 bits wide.   To communicate with the custom =
IP
> I have been using iowrite32() and ioread32() function calls to grab 32 bi=
ts
> at a time.  Is it possible to grab the full 64 bits in one transfer?   I
> don't see an iowrite64() or ioread64() function=85

Not really, at least not for non-cachable regions.  The ppc405 is a 32
bit machine and if it is doing non-cached reads then it will do
individual 32 bit transactions.  You could enable cache on the region,
but if it is accessing device registers then that is probably not what
you want (because there is no cache coherency between your device and
the 405).

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
