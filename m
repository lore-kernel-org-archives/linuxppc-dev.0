Return-Path: <anton@samba.org>
Date: Fri, 19 Apr 2013 08:38:35 +1000
From: Anton Blanchard <anton@samba.org>
To: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
Message-ID: <20130419083835.37f1c180@kryten>
In-Reply-To: <5148C2B3.6010408@linux.vnet.ibm.com>
References: <5148C2B3.6010408@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Adhemerval,

> This patch implement the time syscall as vDSO. I have a glibc patch
> to use it as IFUNC (as latest gettimeofday patch). Below the perf
> numbers:
> 
> Baseline PPC32: 380 nsec
> Baseline PPC64: 352 nsec
> vdso PPC32:      20 nsec
> vdso PPC64:      20 nsec

Very nice speedup. One small performance improvement:

+1:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
+	ld	r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
+	andi.	r0,r8,1			/* pending update ? loop */
+	bne-	1b

Since you are only reading one long you shouldn't need to check the
update count and loop, you will always see a consistent value. The
system call version of time() just does an unprotected load for example.

> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
> as well?
> 
> Any tips, advices, comments?

With the above change and with Michael's comments covered (decent
changelog entry and Signed-off-by):

Acked-by: Anton Blanchard <anton@samba.org>

Anton
