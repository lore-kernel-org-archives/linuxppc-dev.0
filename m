Message-ID: <004e01c1e5ac$a084adf0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Cross compiling glibc-2.2.3
Date: Wed, 17 Apr 2002 10:10:13 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, IGOR LURI

> Anybody has already crosscompiled glibc 2.2.3 for mpc8xx?
I crosscompiled glibc-2.2.5.

> I know that for glibc-2.1.2 there is a patch in denx page, but for glibc
> 2.2.3 is there any patch?

I referenced the patch in denx page, and fixed the crosscompile problem by following procedure.

1. Move the sysdeps/powerpc/fclrexcpt.c to sysdeps/powerpc/fpu/
mv sysdeps/powerpc/fclrexcpt.c sysdeps/powerpc/fpu/

2. Delete the sysdeps/powerpc/memset.S
rm sysdeps/powerpc/memset.S

3. Edit the sysdeps/powerpc/Makefile
#ifeq ($(subdir),gmon)
#libm-support += fenv_const fe_nomask
#endif

4. Compile
CC=${TARGET}-gcc AR=${TARGET}-ar RANLIB=${TARGET}-ranlib \
        CFLAGS="-msoft-float -D_SOFT_FLOAT -mcpu=860 -O2" \
        ../${GLIBC}/configure --host=$TARGET --prefix=${PREFIX} \
        --enable-add-ons=linuxthreads --with-headers=${PREFIX}/include \
        --without-fp

Good luck.
- Sangmoon Kim -


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
