Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 9A51CDDE18
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 15:34:04 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1008402anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jan 2008 20:34:03 -0800 (PST)
Message-ID: <fa686aa40801012034t4cbf4827m82f05ee8f65cd4ee@mail.gmail.com>
Date: Tue, 1 Jan 2008 21:34:03 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "LIU KAN" <liukanh@gmail.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Using C67x00 on PXA255 with ov511
In-Reply-To: <e99250190801011938w54ad1921oc85bb54fc0481b9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e99250190801011938w54ad1921oc85bb54fc0481b9d@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/1/08, LIU KAN <liukanh@gmail.com> wrote:
> Hello, Grant
>
>         Thank you for the work on the patch of c67x00, I have use it
> successfully on PXA255, but I still have some problem.
>         Now I can use c67x00 together with usb-disk in 2.6 kerenl at a
> writing speed around 5MB/s. But when I use c67x00 to connect webcam, which
> is drived by ov511, I get the mosaic like picture in  attachment. And when I
> use cy7c67300 provided by cypress in 2.4 kernel with ov511, it work fine. Is
> this because the speed the c67x00 driver for iso_ transfers is too slow? or
> any other reason?
>         How can I solve the problem?

Most likely the scheduling algorithm is not quite right for the
c67x00.  I've had problems with that in the past myself.  You can try
playing around with the parameters in claim_frame_bw() in
c67x00-sched.c.  The web cam is probably using iso transfers so you
should try to find out if all the requested ISO transfers are actually
getting scheduled by the driver.

Please let me know what you find out.  This driver still needs a lot
of tuning and your observations will help a lot.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
