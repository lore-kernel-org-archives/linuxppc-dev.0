Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBWFn6lb1zDq7W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 01:57:49 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Shuah Khan
 <shuahkh@osg.samsung.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "bamvor.zhangjian@linaro.org" <bamvor.zhangjian@linaro.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "dvhart@infradead.org" <dvhart@infradead.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "dsafonov@virtuozzo.com"
 <dsafonov@virtuozzo.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, Shuah Khan <shuahkh@osg.samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "emilio.lopez@collabora.co.uk" <emilio.lopez@collabora.co.uk>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "luto@kernel.org"
 <luto@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mingo@kernel.org" <mingo@kernel.org>
Subject: RE: [PATCH 8/8] selftests: x86: override clean in lib.mk to fix
 warnings
Date: Mon, 24 Apr 2017 15:57:34 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFD9941@AcuExch.aculab.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <31b94c5cb9a8f71fd3888b648f32c0bd91e4a9bd.1492815938.git.shuahkh@osg.samsung.com>
 <87o9vpyp6h.fsf@concordia.ellerman.id.au>
In-Reply-To: <87o9vpyp6h.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Linuxppc-dev Michael Ellerman
> Shuah Khan <shuahkh@osg.samsung.com> writes:
>=20
> > Add override for lib.mk clean to fix the following warnings from clean
> > target run.
> >
> > Makefile:44: warning: overriding recipe for target 'clean'
> > ../lib.mk:55: warning: ignoring old recipe for target 'clean'
> >
> > Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> > ---
> >  tools/testing/selftests/x86/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selft=
ests/x86/Makefile
> > index 38e0a9c..4d27550 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -40,8 +40,9 @@ all_32: $(BINARIES_32)
> >
> >  all_64: $(BINARIES_64)
> >
> > -clean:
> > +override define CLEAN
> >  	$(RM) $(BINARIES_32) $(BINARIES_64)
> > +endef
>=20
> Simpler as:
>=20
> EXTRA_CLEAN :=3D $(BINARIES_32) $(BINARIES_64)

Actually for builds that insist on crapping all over the source tree I've u=
sed:

clean:
	rm -rf `cat .cvsignore 2>/dev/null`

	David
