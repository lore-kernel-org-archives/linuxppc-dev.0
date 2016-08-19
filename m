Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFq9W6ZqZzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 14:04:47 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id ez1so2768626pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 21:04:47 -0700 (PDT)
Date: Fri, 19 Aug 2016 12:04:43 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [PATCH v3 19/21] powerpc: tm: Always use fp_state and vr_state
 to store live registers
Message-ID: <20160819040442.GA3387@simonLocalRHEL7.x64>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
 <20160817034323.23053-20-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160817034323.23053-20-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2016 at 01:43:21PM +1000, Cyril Bur wrote:
> There is currently an inconsistency as to how the entire CPU register
> state is saved and restored when a thread uses transactional memory
> (TM).
> 
> Using transactional memory results in the CPU having duplicated
> (almost all) of its register state. This duplication results in a set
> of registers which can be considered 'live', those being currently
> modified by the instructions being executed and another set that is
> frozen at a point in time.
> 
> On context switch, both sets of state have to be saved and (later)
> restored. These two states are often called a variety of different
> things. Common terms for the state which only exists after has entered
> a transaction (performed a TBEGIN instruction) in hardware is the
> 'transactional' or 'speculative'.
> 
> Between a TBEGIN and a TEND or TABORT (or an event that causes the
> hardware to abort), regardless of the use of TSUSPEND the
> transactional state can be referred to as the live state.
> 
> The second state is often to referred to as the 'checkpointed' state
> and is a duplication of the live state when the TBEGIN instruction is
> executed. This state is kept in the hardware and will be rolled back
> to on transaction failure.
> 
> Currently all the registers stored in pt_regs are ALWAYS the live
> registers, that is, when a thread has transactional registers their
> values are stored in pt_regs and the checkpointed state is in
> ckpt_regs. A strange opposite is true for fp_state. When a thread is
> non transactional fp_state holds the live registers. When a thread
> has initiated a transaction fp_state holds the checkpointed state and
> transact_fp becomes the structure which holds the live state (at this
> point it is a transactional state). The same is true for vr_state
> 
> This method creates confusion as to where the live state is, in some
> circumstances it requires extra work to determine where to put the
> live state and prevents the use of common functions designed (probably
> before TM) to save the live state.
> 
> With this patch pt_regs, fp_state and vr_state all represent the
> same thing and the other structures [pending rename] are for
> checkpointed state.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Acked-by: Simon Guo <wei.guo.simon@gmail.com>

Thanks,
- Simon
