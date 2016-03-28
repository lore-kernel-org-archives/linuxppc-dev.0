Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYlrb50R9zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 07:29:51 +1100 (AEDT)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 28 Mar 2016 17:29:46 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id EFDFF1DC006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 16:29:38 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SJTAci14483756
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 16:29:10 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SKThqj023718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 17:29:43 -0300
Received: from hactar.localnet ([9.78.144.125])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u2SKTh3b023714
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 17:29:43 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Date: Mon, 28 Mar 2016 17:29:41 -0300
Message-ID: <2042788.6sAC9lOLzB@hactar>
In-Reply-To: <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 28 M=E4rz 2016, 17:06:32 schrieb Thiago Jung Bauermann:
> /home/bauermann/src/linux/tools/testing/selftests/ftrace/test.d/kprob=
e/kp
> robe_ftrace.tc: line 9: echo: write error: Invalid argument
>=20
>     But even without my patch that testcase fails in the same way, so=
 this
> is not a problem introduced by the patch.

That failure is on this line of kprobe_ftrace.tc:

echo _do_fork > set_ftrace_filter

This fails because on powerpc the function symbol has a dot prepended t=
o its=20
name:

# cat available_filter_functions | grep _do_fork
._do_fork

If I do s/_do_fork/._do_fork/ in kprobe_ftrace.tc then all ftrace kprob=
e=20
tests pass:

$ sudo ./ftracetest test.d/kprobe/
=3D=3D=3D Ftrace unit tests =3D=3D=3D
[1] Kprobe dynamic event - adding and removing  [PASS]
[2] Kprobe dynamic event - busy event check     [PASS]
[3] Kprobe dynamic event with arguments [PASS]
[4] Kprobe dynamic event with function tracer   [PASS]
[5] Kretprobe dynamic event with arguments      [PASS]

# of passed:  5
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
