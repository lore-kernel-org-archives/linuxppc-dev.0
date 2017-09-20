Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwBK5wcMzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 19:56:40 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id i130so1382726pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 02:56:40 -0700 (PDT)
Date: Wed, 20 Sep 2017 17:56:35 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 1/3] powerpc: Align bytes before fall back to .Lshort
 in powerpc memcmp
Message-ID: <20170920095635.GA3387@simonLocalRHEL7.x64>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
 <1505815439-18720-2-git-send-email-wei.guo.simon@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0079D63@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0079D63@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2017 at 10:12:50AM +0000, David Laight wrote:
> From: wei.guo.simon@gmail.com
> > Sent: 19 September 2017 11:04
> > Currently memcmp() in powerpc will fall back to .Lshort (compare per byte
> > mode) if either src or dst address is not 8 bytes aligned. It can be
> > opmitized if both addresses are with the same offset with 8 bytes boundary.
> > 
> > memcmp() can align the src/dst address with 8 bytes firstly and then
> > compare with .Llong mode.
> 
> Why not mask both addresses with ~7 and mask/shift the read value to ignore
> the unwanted high (BE) or low (LE) bits.
> 
> The same can be done at the end of the compare with any final, partial word.
> 
> 	David
>  

Yes. That will be better. A prototyping shows ~5% improvement on 32 bytes 
size comparison with v1. I will rework on v2.

Thanks for the suggestion.

BR,
- Simon
