Return-Path: <anton@samba.org>
Date: Wed, 27 Jun 2012 13:59:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] powerpc/perf: Use perf_instruction_pointer in
 callchains
Message-ID: <20120627135928.06e91f76@kryten>
In-Reply-To: <4FEA4013.5030003@freescale.com>
References: <20120626210013.2fbb9044@kryten> <20120626210420.4e5e7e78@kryten>
 <4FEA4013.5030003@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sukadev@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Scott,

> Won't this break core-fsl-emb, which doesn't define
> perf_instruction_pointer()?

It links ok for me. You should get the default version:

#ifndef perf_misc_flags
# define perf_misc_flags(regs) \
                (user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
# define perf_instruction_pointer(regs) instruction_pointer(regs)
#endif

Anton
