Return-Path: <themoken@gmail.com>
Received: from mail-ig0-x243.google.com (mail-ig0-x243.google.com
 [IPv6:2607:f8b0:4001:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlWK501YYzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:39:52 +1000 (AEST)
Received: by mail-ig0-x243.google.com with SMTP id fn8so7504157igb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 10:39:52 -0700 (PDT)
MIME-Version: 1.0
Sender: themoken@gmail.com
In-Reply-To: <20160412054041.GA21633@gate.crashing.org>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-3-git-send-email-jack@codezen.org>
 <20160412054041.GA21633@gate.crashing.org>
Date: Wed, 13 Apr 2016 12:39:50 -0500
Message-ID: <CAGXwabSfGfpfRvCDzbKy-f4-tkZHgCo-ZHEfviajvnkXEby+ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Load Monitor Register Support
From: Jack Miller <jack@codezen.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, michael.neuling@au1.ibm.com,
 michaele@au1.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks, yeah, that's more readable and more correct. I'll change it in
the next spin.

- Jack

On Tue, Apr 12, 2016 at 12:40 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> Hi,
>
> On Mon, Apr 11, 2016 at 01:57:44PM -0500, Jack Miller wrote:
>>  __init_FSCR:
>>       mfspr   r3,SPRN_FSCR
>> +     andi.   r3,r3,(~FSCR_LM)@L
>>       ori     r3,r3,FSCR_TAR|FSCR_DSCR|FSCR_EBB
>>       mtspr   SPRN_FSCR,r3
>>       blr
>
> This clears the top 48 bits as well.  Shouldn't matter currently; but
> more robust (and easier to read, if you know the idiom) is
>
>         ori     r3,r3,FSCR_LM|FSCR_TAR|FSCR_DSCR|FSCR_EBB
>         xori    r3,r3,FSCR_LM
>
>
> Segher
