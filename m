Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ADFC52C00B6
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 14:29:39 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 8 Aug 2013 09:51:10 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D4C431258051
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 09:59:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r784Uo0H39256218
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 10:00:50 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r784TX5A029023
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 04:29:33 GMT
Message-ID: <52031EAE.5080005@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 09:59:34 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 00/11] Add compression support to pstore
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
 <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
 <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
 <51FFDC8B.7010909@linux.vnet.ibm.com>
 <CA+8MBb+1LpR+Cx=84WZT98U5eqZcm1KriUP75aCg+uSrXrb3Yw@mail.gmail.com>
 <51FFFFEB.3030907@linux.vnet.ibm.com>
 <CA+8MBbK9oZJO+RJGC-7riO=Kz=UbRcAvQ-nDi=2GLyvEDpoc7g@mail.gmail.com>
 <CA+8MBbKA+P4vs3utSKQ-LPMW3ybrWOp=f3FH6ahv1YtwnMm5KA@mail.gmail.com>
 <5201A9BD.4090503@linux.vnet.ibm.com>
 <CA+8MBbJS0Dymn4OABi-rW9M5Bw-ZZ6DaEjQOW-oki+4ge4BDtg@mail.gmail.com>
 <5201D777.8060303@linux.vnet.ibm.com>
 <CA+8MBb+pkKpaEDs6J_XbzM3wzady2MjdU+jcDP+jH1f1VBxG5w@mail.gmail.com>
 <CA+8MBb+dNkT_xpqL6oy=D3UqCtEwAci5fatw-0crCFLMAGE1nA@mail.gmail.com>
In-Reply-To: <CA+8MBb+dNkT_xpqL6oy=D3UqCtEwAci5fatw-0crCFLMAGE1nA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 07 August 2013 11:00 PM, Tony Luck wrote:
> Oh - one more thing - and my apologies for not spotting this before:
>
>                  dst = allocate_buf_for_compression(big_buf_sz);
>
> No - you may not call kmalloc() in oops/panic context.  Please pre-allocate
> everything you need in some initialization code to make sure that we don't
> fail in the panic path because we can't get the memory we need.
>
> -Tony

Sure. I had this in mind. At the same time memory consumed for compression is 
quite high.
For the compression parameters used, workspace will be 30k and big_buf will be 17.5k
for the record size of 7896 that you have mentioned.

So total memory consumed for compression and decompression will close 47.5k.

When we preallocate, we can use the same big_buf for compression as well as 
decompression.
Also workspace will be one for both. By allocating max of inflate workspace size 
and deflate
workspace size. We can save memory here.

If pre-allocating close to 50k of buffer is not a issue. We can go ahead with 
this approach.

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
