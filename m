Return-Path: <SRS0=TRtS=2J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21048C43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 04:32:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D56A2082E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 04:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dfBC35GTzDqsG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 15:32:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=vz7s=2j=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47df8F1BNHzDqkb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2019 15:31:08 +1100 (AEDT)
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8A11B2082E;
 Thu, 19 Dec 2019 04:31:04 +0000 (UTC)
Date: Wed, 18 Dec 2019 23:31:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: "ftrace: Rework event_create_dir()" triggers boot error messages
Message-ID: <20191218233101.73044ce3@rorschach.local.home>
In-Reply-To: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
References: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 18 Dec 2019 22:58:23 -0500
Qian Cai <cai@lca.pw> wrote:

> The linux-next commit "ftrace: Rework event_create_dir()=E2=80=9D [1] tri=
ggers boot warnings
> for Clang-build (Clang version 8.0.1) kernels (reproduced on both arm64 a=
nd powerpc).
> Reverted it (with trivial conflict fixes) on the top of today=E2=80=99s l=
inux-next fixed the issue.
>=20
> configs:
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
>=20
> [1] https://lore.kernel.org/lkml/20191111132458.342979914@infradead.org/
>=20
> [  115.799327][    T1] Registered efivars operations
> [  115.849770][    T1] clocksource: Switched to clocksource arch_sys_coun=
ter
> [  115.901145][    T1] Could not initialize trace point events/sys_enter_=
rt_sigreturn
> [  115.908854][    T1] Could not create directory for event sys_enter_rt_=
sigreturn
> [  115.998949][    T1] Could not initialize trace point events/sys_enter_=
restart_syscall
> [  116.006802][    T1] Could not create directory for event sys_enter_res=
tart_syscall
> [  116.062702][    T1] Could not initialize trace point events/sys_enter_=
getpid
> [  116.069828][    T1] Could not create directory for event sys_enter_get=
pid
> [  116.078058][    T1] Could not initialize trace point events/sys_enter_=
gettid
> [  116.085181][    T1] Could not create directory for event sys_enter_get=
tid
> [  116.093405][    T1] Could not initialize trace point events/sys_enter_=
getppid
> [  116.100612][    T1] Could not create directory for event sys_enter_get=
ppid
> [  116.108989][    T1] Could not initialize trace point events/sys_enter_=
getuid
> [  116.116058][    T1] Could not create directory for event sys_enter_get=
uid
> [  116.124250][    T1] Could not initialize trace point events/sys_enter_=
geteuid
> [  116.131457][    T1] Could not create directory for event sys_enter_get=
euid
> [  116.139840][    T1] Could not initialize trace point events/sys_enter_=
getgid
> [  116.146908][    T1] Could not create directory for event sys_enter_get=
gid
> [  116.155163][    T1] Could not initialize trace point events/sys_enter_=
getegid
> [  116.162370][    T1] Could not create directory for event sys_enter_get=
egid
> [  116.178015][    T1] Could not initialize trace point events/sys_enter_=
setsid
> [  116.185138][    T1] Could not create directory for event sys_enter_set=
sid
> [  116.269307][    T1] Could not initialize trace point events/sys_enter_=
sched_yield
> [  116.276811][    T1] Could not create directory for event sys_enter_sch=
ed_yield
> [  116.527652][    T1] Could not initialize trace point events/sys_enter_=
munlockall
> [  116.535126][    T1] Could not create directory for event sys_enter_mun=
lockall
> [  116.622096][    T1] Could not initialize trace point events/sys_enter_=
vhangup
> [  116.629307][    T1] Could not create directory for event sys_enter_vha=
ngup
> [  116.783867][    T1] Could not initialize trace point events/sys_enter_=
sync
> [  116.790819][    T1] Could not create directory for event sys_enter_sync
> [  117.723402][    T1] pnp: PnP ACPI init

I noticed that all of the above have zero parameters. Does the
following patch fix it?

(note, I prefer "ret" and "i" on different lines anyway)

-- Steve

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 53935259f701..abb70c71fe60 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -269,7 +269,8 @@ static int __init syscall_enter_define_fields(struct tr=
ace_event_call *call)
 	struct syscall_trace_enter trace;
 	struct syscall_metadata *meta =3D call->data;
 	int offset =3D offsetof(typeof(trace), args);
-	int ret, i;
+	int ret =3D 0;
+	int i;
=20
 	for (i =3D 0; i < meta->nb_args; i++) {
 		ret =3D trace_define_field(call, meta->types[i],
