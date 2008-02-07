Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id C0983DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 16:26:07 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so912012anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 21:26:06 -0800 (PST)
Message-ID: <fa686aa40802062126w122ed215y5d7bb86b6b1927a2@mail.gmail.com>
Date: Wed, 6 Feb 2008 22:26:06 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>,
	"Tony Breeds" <tony@bakeyournoodle.com>
Subject: Re: Please pull powerpc.git for-2.6.25 branch
In-Reply-To: <18346.31072.982702.10064@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18346.31072.982702.10064@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/6/08, Paul Mackerras <paulus@samba.org> wrote:
> Tony Breeds (1):
>       [POWERPC] Use a sensible default for clock_getres() in the VDSO

Hmm, this commit breaks ppc32 (mpc5200) build with my cross compiler
(ELDK 4.1; gcc 4.0; binutils 2.16.1).  Is this a bug in the code or
the compiler?

grant@trillian:~/hacking/linux-2.6$ ppc6xx make -j3
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  CC      arch/powerpc/kernel/asm-offsets.s
arch/powerpc/kernel/asm-offsets.c: In function 'main':
arch/powerpc/kernel/asm-offsets.c:316: warning: asm operand 0 probably
doesn't match constraints
arch/powerpc/kernel/asm-offsets.c:316: error: impossible constraint in 'asm'
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
grant@trillian:~/hacking/linux-2.6$


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
