Return-Path: <enrico.scholz@sigma-chemnitz.de>
Received: from mail.cvg.de (mail.cvg.de [62.153.82.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.cvg.de", Issuer "SIGMA Chemnitz Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57D8C2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 00:27:24 +1000 (EST)
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: balbi@ti.com
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime STATUS
 for IN xfer
References: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120906131708.GJ29202@arwen.pp.htv.fi>
Date: Thu, 06 Sep 2012 16:27:12 +0200
In-Reply-To: <20120906131708.GJ29202@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Thu, 6 Sep 2012 16:17:10 +0300")
Message-ID: <lyehmf1b27.fsf@ensc-virt.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felipe Balbi <balbi@ti.com> writes:

>> > Because the fsl_udc_core driver shares one 'status_req' object for the
>> > complete ep0 control transfer, it is not possible to prime the final
>> > STATUS phase immediately after the IN transaction.  E.g. ch9getstatus()
>> > executed:
>> > 
>> > | req = udc->status_req;
>> > | ...
>> > | list_add_tail(&req->queue, &ep->queue);
>> > | if (ep0_prime_status(udc, EP_DIR_OUT))
>> > |       ....
>> > |       struct fsl_req *req = udc->status_req;
>> > |       list_add_tail(&req->queue, &ep->queue);
>> > 
>> > which corrupts the ep->queue list by inserting 'status_req' twice.  This
>> > causes a kernel oops e.g. when 'lsusb -v' is executed on the host.
>> > 
>> > Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by moving it
>> > into the ep0 completion handler.
>> > 
>> Enrico, thanks for pointing this problem.
>> 
>> As "prime STATUS phase immediately after the IN transaction" is followed
>> USB 2.0 spec, to fix this problem, it is better to add data_req for ep0.
>> In fact, it is already at FSL i.mx internal code, just still not mainlined.
>
> so, do I get an Acked-by to this patch ? Does it need to go on v3.6-rc
> or can it wait until v3.7 merge window ?

Without this (or the mentioned data_req patch), I can crash a g_multi
gadget by executing 'lsusb -v' as root on the host.  Should not be
exploitable (only a BUG_ON() is triggered) but issue should be fixed
asap.


Enrico
