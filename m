Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 11:22:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9E1238EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 11:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E1238EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGhjY5ZpGzDrfb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 22:22:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGhcC2ZjHzDrbB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2021 22:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Sr3GWt03; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DGhc76r2cz9s2g;
 Thu, 14 Jan 2021 22:17:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1610623049;
 bh=g5Oz3V3jZktqK95uiv3rPpxchACuTU1uFgEbh5ltcbo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Sr3GWt03xjCOvNaqNtx/K59FP1sLhhrrm36EaKf/c6vJVOoK6u9zmCIpFJ5B+Yl0o
 KxzuSY9Lp9mjZhRxvOQTUsmNOf4sim3b4WhKm+KY4B7XNMr3PRDhF+MbSnTv92UgrN
 ypyqqe5Ulp0UGHaomWUGaNiAFjBaU9hTeGp+cYPUWXuDDnyGyq7dFAj/uL+xmJ1iO9
 EASuN7BW89pdtCTuiX0wJzBeuI6XG14AVlv+flKr7VO/7GEwoP9sHEBCHrBQGo9Q6P
 /Y3/WsUpb2JuEtg2TfIhks9hxH/HmjyfmH/38cy2s+x3KuKYtWmPGSnU2S8C47LmYW
 /BC8Rc0mIO6Jw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Namhyung Kim <namhyung@kernel.org>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
In-Reply-To: <CAM9d7cgmUqLX+C1wDPe9qaxDh1tY4sVmLx2qZqey3CQSmZSo2Q@mail.gmail.com>
References: <20210113080128.10286-1-jslaby@suse.cz>
 <20210113104618.GB1331835@krava>
 <388a2e21-14ee-4609-84d0-c8824154c015@suse.cz>
 <CAM9d7cgmUqLX+C1wDPe9qaxDh1tY4sVmLx2qZqey3CQSmZSo2Q@mail.gmail.com>
Date: Thu, 14 Jan 2021 22:17:25 +1100
Message-ID: <87sg73kbsq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Namhyung Kim <namhyung@kernel.org> writes:
> On Wed, Jan 13, 2021 at 8:43 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> On 13. 01. 21, 11:46, Jiri Olsa wrote:
>> > On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
>> >> With LTO, there are symbols like these:
>> >> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
>> >>   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
>> >>
>> >> This comes from a runtime/debug split done by the standard way:
>> >> objcopy --only-keep-debug $runtime $debug
>> >> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
>> >>
...
>> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> >> index f3577f7d72fe..a31b716fa61c 100644
>> >> --- a/tools/perf/util/symbol-elf.c
>> >> +++ b/tools/perf/util/symbol-elf.c
>> >> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>> >>              if (sym.st_shndx == SHN_ABS)
>> >>                      continue;
>> >>
>> >> -            sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
>> >> +            sec = elf_getscn(syms_ss->elf, sym.st_shndx);
>> >>              if (!sec)
>> >>                      goto out_elf_end;
>> >
>> > we iterate symbols from syms_ss, so the fix seems to be correct
>> > to call elf_getscn on syms_ss, not on runtime_ss as we do now
>> >
>> > I'd think this worked only when runtime_ss == syms_ss
>>
>> No, because the headers are copied 1:1 from runtime_ss to syms_ss. And
>> runtime_ss is then stripped, so only .debug* sections are removed there.
>> (And syms_ss's are set as NOBITS.)
>>
>> We iterated .debug* sections in syms_ss and used runtime_ss section
>> _headers_ only to adjust symbols (sometimes). That worked.
>
> It seems PPC has an opd section only in the runtime_ss and that's why
> we use it for section headers.

At least on my system (Ubuntu 20.04.1) I see .opd in the debug file with
NOBITS set:

$ readelf -e vmlinux.debug | grep opd
  [37] .opd              NOBITS           c000000001c1f548  01202e14


But possibly that's not the case with older toolchains?

cheers
