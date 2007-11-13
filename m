Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Message-ID: <18233.12821.992452.841806@cargo.ozlabs.ibm.com>
Date: Tue, 13 Nov 2007 16:11:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH v2] fix multiple bugs in rtas_ibm_suspend_me code
In-Reply-To: <20071109204408.GS9695@localdomain>
References: <20071106044309.GK9695@localdomain>
	<20071109204408.GS9695@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch writes:

> There are several issues with the rtas_ibm_suspend_me code, which
> enables platform-assisted suspension of an LPAR for migration or
> hibernation as covered in PAPR 2.2.

On a uniprocessor configuration, with this patch I get:

  CC      arch/powerpc/kernel/rtas.o
/home/paulus/kernel/powerpc/arch/powerpc/kernel/rtas.c: In function ‘rtas_percpu_suspend_me’:
/home/paulus/kernel/powerpc/arch/powerpc/kernel/rtas.c:702: error: implicit declaration of function ‘get_hard_smp_processor_id’
make[2]: *** [arch/powerpc/kernel/rtas.o] Error 1

I think you need to #include <asm/smp.h> in rtas.c.

Paul.
