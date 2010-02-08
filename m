Return-Path: <xiyou.wangcong@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 3950BB7D17
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 18:07:49 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so442758qwb.15
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Feb 2010 23:07:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100208145240.FB58.A69D9226@jp.fujitsu.com>
References: <20100208141716.FB55.A69D9226@jp.fujitsu.com>
	<9729.1265607469@neuling.org>
	<20100208145240.FB58.A69D9226@jp.fujitsu.com>
Date: Mon, 8 Feb 2010 15:07:47 +0800
Message-ID: <2375c9f91002072307h4af1ba6dw1b7a598582991dc4@mail.gmail.com>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, stable@kernel.org, aeb@cwi.nl,
	Oleg Nesterov <oleg@redhat.com>, miltonm@bga.com,
	James Morris <jmorris@namei.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linux-fsdevel@vger.kernel.org,
	Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 8, 2010 at 2:05 PM, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com> wrote:
>> --- linux-2.6-ozlabs.orig/fs/exec.c
>> +++ linux-2.6-ozlabs/fs/exec.c
>> @@ -627,10 +627,13 @@ int setup_arg_pages(struct linux_binprm
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto out_unlock;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 stack_base =3D min(EXTRA_STACK_VM_PAGES * PAGE_SIZE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0current->signal->rlim[RLIMIT_STACK].rlim_cur -
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0PAGE_SIZE);
>
> This line is a bit unclear why "- PAGE_SIZE" is necessary.
> personally, I like following likes explicit comments.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stack_expand =3D EXTRA_STACK_VM_PAGES * PAGE_S=
IZE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stack_lim =3D ACCESS_ONCE(rlim[RLIMIT_STACK].r=
lim_cur);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initial stack must not cause stack overflow=
. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stack_expand + PAGE_SIZE > stack_lim)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stack_expand =3D s=
tack_lim - PAGE_SIZE;
>
> note: accessing rlim_cur require ACCESS_ONCE.
>
>
> Thought?

It's better to use the helper function: rlimit().
