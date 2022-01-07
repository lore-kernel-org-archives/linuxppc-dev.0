Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E77C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jan 2022 10:22:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JVfR94DMKz3bcv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jan 2022 21:22:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=iogearbox.net (client-ip=213.133.104.62;
 helo=www62.your-server.de; envelope-from=daniel@iogearbox.net;
 receiver=<UNKNOWN>)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JVfQk0Y4Pz30Jw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jan 2022 21:21:50 +1100 (AEDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <daniel@iogearbox.net>)
 id 1n5mNR-000D6H-Be; Fri, 07 Jan 2022 11:21:41 +0100
Received: from [85.1.206.226] (helo=linux.home)
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1n5mNR-000Tka-2V; Fri, 07 Jan 2022 11:21:41 +0100
Subject: Re: [PATCH 04/13] tools/bpf: Rename 'struct event' to avoid naming
 conflict
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <c13cb3767d26257ca4387b8296b632b433a58db6.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8915d556-3bd4-d45c-ffb7-8ab0d498b9f7@iogearbox.net>
Date: Fri, 7 Jan 2022 11:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c13cb3767d26257ca4387b8296b632b433a58db6.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26415/Fri Jan  7 10:26:59 2022)
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
Cc: ykaliuta@redhat.com, johan.almbladh@anyfinetworks.com,
 linuxppc-dev@lists.ozlabs.org, song@kernel.org, bpf@vger.kernel.org,
 Jiri Olsa <jolsa@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/6/22 12:45 PM, Naveen N. Rao wrote:
> On ppc64le, trying to build bpf seltests throws the below warning:
>    In file included from runqslower.bpf.c:5:
>    ./runqslower.h:7:8: error: redefinition of 'event'
>    struct event {
> 	 ^
>    /home/naveen/linux/tools/testing/selftests/bpf/tools/build/runqslower/vmlinux.h:156602:8:
>    note: previous definition is here
>    struct event {
> 	 ^
> 
> This happens since 'struct event' is defined in
> drivers/net/ethernet/alteon/acenic.h . Rename the one in runqslower to a
> more appropriate 'runq_event' to avoid the naming conflict.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
