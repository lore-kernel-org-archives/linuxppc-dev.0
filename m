Return-Path: <vwool@ru.mvista.com>
Date: Thu, 26 Oct 2006 10:43:27 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [0/2] build failure for E500 CPUs w/ CONFIG_OPROFLE=y
Message-Id: <20061026104327.8278e300.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: oprofile-list@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello folks,

we've observed the following build failure compiling the kernel w/ oprofile on 8540 (FSL_BOOKE):

CC      arch/powerpc/oprofile/op_model_7450.o
arch/powerpc/oprofile/op_model_7450.c:62: error: conflicting types for
'pmc_start_ctrs'
include/asm/pmc.h:41: error: previous declaration of 'pmc_start_ctrs' was here
arch/powerpc/oprofile/op_model_7450.c:62: error: conflicting types for
'pmc_start_ctrs'
include/asm/pmc.h:41: error: previous declaration of 'pmc_start_ctrs' was here
arch/powerpc/oprofile/op_model_7450.c:73: warning: static declaration of
'pmc_stop_ctrs' follows non-static declaration
include/asm/pmc.h:42: warning: previous declaration of 'pmc_stop_ctrs' was here
arch/powerpc/oprofile/op_model_7450.c: In function `fsl7450_start':
arch/powerpc/oprofile/op_model_7450.c:140: warning: implicit declaration of
function `ctr_write'
arch/powerpc/oprofile/op_model_7450.c: In function `fsl7450_handle_interrupt':
arch/powerpc/oprofile/op_model_7450.c:182: warning: implicit declaration of
function `ctr_read'
make[1]: *** [arch/powerpc/oprofile/op_model_7450.o] Error 1

The thing is that op_model_7450.c is compiled when CONFIG_PPC32 is true which might be reasonable but results in conflicting functions' types when compiled w/ CONFIG_FSL_BOOKE=y. Effectively, op_model_fsl_booke.c introduces the functions with the same names as op_model_7450.c but with different declarations, and latter ones are static while former ones are not, and this can drive any compiler mad.

This message will have two *alternative* follow-up patches which are probably more likely RFCs rather than complete solutions, but still I'm sure it's reasonable to look at those, b/c those represent two different approaches and we need to decide which way to go first.

Vitaly
