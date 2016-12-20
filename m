Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjMNy6qZVzDwPB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 13:36:34 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id i5so518148pgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 18:36:34 -0800 (PST)
Date: Tue, 20 Dec 2016 12:36:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 07/12] powerpc: Add support to take additional
 parameter in MASKABLE_* macro
Message-ID: <20161220121412.213b9ca0@roar.ozlabs.ibm.com>
In-Reply-To: <1482134828-18811-8-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-8-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Dec 2016 13:37:03 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> To support addition of "bitmask" to MASKABLE_* macros,
> factor out the EXCPETION_PROLOG_1 macro.
> 
> Currently soft_enabled is used as the flag to determine
> the interrupt state. Patch extends the soft_enabled
> to be used as a mask instead of a flag.

This is really the core part of the patch -- after reversing the
soft_enable logic to be a disable boolean, now it's being extended
to be a disable mask. The exception macro changes just allow an
interrupt type bit to be passed in later.

I should have picked it up earlier, but if you do end up submitting
another version, perhaps consider splitting the disable mask change
and putting it after patch 5.

Thanks,
Nick
