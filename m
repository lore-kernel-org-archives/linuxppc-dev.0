Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tB83q2FwZzDvXS
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Nov 2016 06:32:23 +1100 (AEDT)
Date: Sun, 6 Nov 2016 06:31:51 +1100
From: Anton Blanchard <anton@samba.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 ast@kernel.org, linux-kernel@vger.kernel.org, oss@buserror.net,
 paul.gortmaker@windriver.com, duwe@lst.de, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, oohall@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
Message-ID: <20161106063151.3ef04e9e@kryten>
In-Reply-To: <581C1D32.50108@linux.vnet.ibm.com>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten>
 <581ACDF2.1010409@linux.vnet.ibm.com>
 <8737j8opwb.fsf@concordia.ellerman.id.au>
 <581B110F.9050805@linux.vnet.ibm.com>
 <e993dc5c-7a90-e43b-b761-a70a79b3d1d9@au1.ibm.com>
 <581C1D32.50108@linux.vnet.ibm.com>
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

Hi,

> kprobe, uprobe, hw-breakpoint and xmon are the only user of
> emulate_step.
> 
> Kprobe / uprobe single-steps instruction if they can't emulate it, so
> there is no problem with them. As I mention, hw-breakpoint is broken.
> However I'm not sure about xmon, I need to check that.

I was mostly concerned that it would impact kprobes. Sounds like we are
ok there.

> So yes, there is no user-visible feature that depends on this.

Aren't hardware breakpoints exposed via perf? I'd call perf
user-visible.

Anton
