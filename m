Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D3BDDDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 19:12:09 +1100 (EST)
Date: Fri, 21 Nov 2008 16:44:29 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] sh: dynamic ftrace support.
Message-ID: <20081121074428.GC28447@linux-sh.org>
References: <20081120203415.251344054@goodmis.org>
	<20081120203551.633484431@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120203551.633484431@goodmis.org>
Cc: Matt Fleming <mjf@gentoo.org>, Jim Radford <radford@galvanix.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 03:34:16PM -0500, Steven Rostedt wrote:
> +} elsif ($arch eq "sh") {
> +    $section_regex = "Disassembly of section\\s+(\\S+):";
> +    $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
> +    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
> +    $type = ".long";
> +
> +    # force flags for this arch
> +    $ld .= " -m shlelf_linux";
> +    $objcopy .= " -O elf32-sh-linux";
> +    $cc .= " -m32";
> +

Note that if the $alignment changes are in this version, you will also
need to add an $alignment = 2; for sh. That was in Matt's original patch,
but I stripped the alignment line out in the commit given that it was not
yet present in the mainline version of the script.
