Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FBC5AE5E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:11:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2172086D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2172086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blastwave.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hJC42grdzDrCv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 11:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=blastwave.org
 (client-ip=209.17.115.51; helo=atl4mhob13.registeredsite.com;
 envelope-from=dclarke@blastwave.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=blastwave.org
Received: from atl4mhob13.registeredsite.com (atl4mhob13.registeredsite.com
 [209.17.115.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 43h7422r7VzDr2c
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 04:20:01 +1100 (AEDT)
Received: from mailpod.hostingplatform.com
 (atl4qobmail02pod2.registeredsite.com [10.30.77.36])
 by atl4mhob13.registeredsite.com (8.14.4/8.14.4) with ESMTP id x0IHJwKY026603
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 12:19:58 -0500
Received: (qmail 1895 invoked by uid 0); 18 Jan 2019 17:19:58 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?)
 (dclarke@blastwave.org@174.118.245.214)
 by 0 with ESMTPA; 18 Jan 2019 17:19:58 -0000
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To: Arnd Bergmann <arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
 <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
From: Dennis Clarke <dclarke@blastwave.org>
Message-ID: <37173869-7516-55c5-8e4a-0c7bef011a62@blastwave.org>
Date: Fri, 18 Jan 2019 12:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 19 Jan 2019 11:08:48 +1100
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Networking <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/18/19 12:14 PM, Arnd Bergmann wrote:
> On Fri, Jan 18, 2019 at 5:57 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>>
>> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
>>> This is a minor update of the patches I posted last week, I
>>> would like to add this into linux-next now, but would still do
>>> changes if there are concerns about the contents. The first
>>> version did not see a lot of replies, which could mean that
>>> either everyone is happy with it, or that it was largely ignored.
>>>
>>> See also the article at https://lwn.net/Articles/776435/.
>>
>> I would be happy to read "Approaching the kernel year-2038 end game"
>> however it is behind a pay wall.  Perhaps it may be best to just
>> host interesting articles about open source idea elsewhere.
> 
> It's a short summary of the current state.

Oh, I pay. Also to FSF and other places however I was merely ranting
very very quietly that so much open source is becoming commercialized
in so many ways.  Sort of expected really.

Pardon my little rant .. I will go back to hacking OpenSSL 1.1.1a and
trying to get Apache httpd 2.4.38 release running cleanly.

Dennis



