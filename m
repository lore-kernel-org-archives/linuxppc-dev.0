Return-Path: <consul.kautuk@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54629B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 01:13:53 +1100 (EST)
Received: by ggni2 with SMTP id i2so79924ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 07:13:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332252387.18960.424.camel@twins>
References: <1332249595-2678-1-git-send-email-consul.kautuk@gmail.com>
 <1332252387.18960.424.camel@twins>
Date: Tue, 20 Mar 2012 10:13:49 -0400
Message-ID: <CAFPAmTR53wQRwVCGqe3942GTHVD5zO2Rkvpnk1tR19o7Fm-aow@mail.gmail.com>
Subject: Re: [PATCH 04/20] powerpc/mm/fault.c: Port OOM changes to
 do_page_fault
From: Kautuk Consul <consul.kautuk@gmail.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org,
 Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>,
 Paul Mackerras <paulus@samba.org>, "Mohd. Faris" <mohdfarisq2010@gmail.com>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2012 at 10:06 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> w=
rote:
> On Tue, 2012-03-20 at 09:19 -0400, Kautuk Consul wrote:
>> +#ifd#ifdef CONFIG_PPC_SMLPAR
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (firmware_has_feature(F=
W_FEATURE_CMO)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_di=
sable();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_lppaca=
()->page_ins +=3D (1 << PAGE_FACTOR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_en=
able();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +#end#endif
>
> That's curious CPP usage....

Quite baffling.
I don't know how that happened.
I have sent a v2 for this already.
