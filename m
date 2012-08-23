Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B92B42C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 12:02:04 +1000 (EST)
Message-ID: <50358D6E.20209@windriver.com>
Date: Thu, 23 Aug 2012 09:54:54 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/3] powerpc: Bail out of KGDB when we've been triggered
References: <1345632192-19810-1-git-send-email-tiejun.chen@windriver.com>
 <1345632192-19810-2-git-send-email-tiejun.chen@windriver.com>
 <6AE080B68D46FC4BA2D2769E68D765B7059AE7E7@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7059AE7E7@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2012 11:07 PM, Tabi Timur-B04825 wrote:
> On Wed, Aug 22, 2012 at 5:43 AM, Tiejun Chen <tiejun.chen@windriver.com> wrote:
> 
>> +int kgdb_skipexception(int exception, struct pt_regs *regs)
>> +{
>> +       if (kgdb_isremovedbreak(regs->nip))
>> +               return 1;
>> +
>> +       return 0;
>> +}
> 
> int kgdb_skipexception(int exception, struct pt_regs *regs)
> {
>         return !!kgdb_isremovedbreak(regs->nip));
> }
> 
> If the caller only cares about zero vs. non-zero, you can drop the !!.

Yes, so 'return kgdb_isremovedbreak(regs->nip);' is already fine and simple.

I'll update this as v2 so thanks your comment.

Tiejun
