Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C6606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=j/WcXE9X;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=tuDt3qfc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZlYp2nkCz2yDD;
	Thu, 26 Nov 2026 16:32:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.164 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795671166;
	cv=pass; b=T4GLpA5lYpNLZYBr1cWVWuxBB8BtBD7zlo4ojCnH9+tj6/and+T+vxfu558yMoGf+lx+hQWraZEGfKKMRSsotQjq5siCDgcexuApc77MPpCKfTssdZB/NI9vFbBXeyD9qWnynzvDbuFA5YBgGdIGCaR36K4ku21Io76o1It997P+anXTDgjYLan03G625XlzcspAIYBinbVgB6Hw4kqJD5bFR5OI5d/5T4ZBbsXLLIZba0tajJmCPoN4XB2wmeWoeajD5m5/tvXuNO21b+mmBEFIkepB3QIGTdtnJvLWUvjJNiDCSUCQqxqAwviecxmR2Eyf1GQUJcjWsSRQ2lI6Lw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795671166; c=relaxed/relaxed;
	bh=CGriERpqNkulcELAKAdEuvFTKnGo71JGt80ItgcyMds=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A0KSPlgWNS9LX638YHl39QqjKnW7foN1BUVWv59C6/alYzvHmnS173BdXLEN/ATVRS2Z4Xvpg0RM92zL9BpQHsTBgHKEhRnj4jU/GwoDsl3wXGD4A1uh0f8WKauOfUpG7GgEUq3pLRY95V0401GFXGgAgJPpALcQOEZh//YmezPNHBkf2wwLNCi2GjondnNfDG/NJeF7jQPGzrjNx5L06cN9otjginOMAa5VWXL/BNgr7v4GvZfDP78OiUphMol0KyRB2fkPu5hoTYrUSBQUWVHbbyjZybkdB8M3equ1nplGvLhr7LtdWAkFUeJsfw7KyukWZBXvZq++jNyRWaxo5w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=j/WcXE9X; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=tuDt3qfc; dkim-atps=neutral; spf=pass (client-ip=81.169.146.164; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=j/WcXE9X;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=tuDt3qfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.164; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZlYj43qPz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 16:32:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1795671151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NGx2tA/FglNSe37qgaaVt8/onoZ2qESknVN0/LQMvkCui2p0XNO8thDn00E/eLd5AG
    jZ/AvxCTXUT6g8bmPDeM5uAvxrHouwoBuFpkD5G4wtIUcLiuOW06ZGsG3MLlgw4sVotA
    Zzp6z44l4JhSzGUBI1G26fGEhlkZ58ZwSeiSay79zH2gGuMWI75eWgf3Z/ncs0JGATkT
    uP219+ykG+YXUJ5Hd3jWmfvuF156CO+uvi5nNmuPovE5jlidcXiI2O5fGMCjyST8yFK7
    7BeKGvQMmNFSOQRzjhCNisYiWu4euepw+UOGEHLMS74byv5uK8FdrmyYJWlcmSDr/9M3
    GqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795671151;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CGriERpqNkulcELAKAdEuvFTKnGo71JGt80ItgcyMds=;
    b=RHJPttzneIW6TN/zy+FRZ9q4lPoVHlcYJucofB3Z+C1qlYazMKFf3Wpqj2Qsyt3PCn
    yum8eBT5lEzuolzEd424ZIdTri/tuUdbY6Mqmmat5gIPr5ciCkPsYxuTMOHzQSTEFDEb
    nYA+WI9iEZkcgDNif4ZI/3GXhSoKbnE6YaeGejjnwcAJdntlxGDGzE0LYIvkOTBK6WP2
    daPazC7zO/Dq03sNFbvn4uPWID3ce3Kfa0nMzg9UPaR9rlZYJjcVcORmJEBnyy9J4c6y
    4n5BjyPEkLW6R5TXana5IsNUNEGWdN6hc83uT8i1Iiq/pPnajnVAoAuaUJNlBDXpvOxW
    vXPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795671151;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CGriERpqNkulcELAKAdEuvFTKnGo71JGt80ItgcyMds=;
    b=j/WcXE9X0bfzwWoSYbaFJ49etptrZM4nnFjR+ZgGptLXkZVh34qNe4rbqwa6iTdfjn
    HOtJP4TRCYW2hGaqn2igzbqX2f3r95jNApcyJDocLBqoqChbmFUPVcFGL5ax8lsTMY8F
    l2dIdcONOCCUK8NrfnmTvueHO8sy9EiDcwQVAWThbv8xvT2v6KMkuaJ7fK1aLV87bYje
    0nUZWsHqQo+KKOsI+7RCbxYNo/4j0o2UCddiZPCVAOqMi3KYVp9kMEjfvNzO4v4DczbB
    movZSsPyFstvwclfF25DU1vURkHsd+H/9l473lGu4W5LUAEv6kbAK6i8g5mm1hrItS/0
    wx1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795671151;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CGriERpqNkulcELAKAdEuvFTKnGo71JGt80ItgcyMds=;
    b=tuDt3qfcL8eoWEdrYS3upxPqWhIOPEHAsITd1VnYWQifx8GJUbLfstaDnBi7WGd8oQ
    MpQOOCk4Ta/V5ibIQnCA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+t7nc="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92AQ5WUhsM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 06:32:30 +0100 (CET)
Subject: Re: [PREEMPT] Kernel panic - not syncing: stack-protector: Kernel
 stack is corrupted
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com,
 amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>, Christian Zigotzky <info@xenosoft.de>
References: <D0ECD6B8-7F15-48C8-87A4-DFE5F35A42D8@xenosoft.de>
 <EEB13352-2FD9-4169-B709-FF7822AA591F@xenosoft.de>
 <298e965b-6de2-43b6-a6c0-e844b115438b@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <51d298fc-6af2-380a-6ae1-05c0e674cc14@xenosoft.de>
Date: Thu, 26 Nov 2026 06:32:29 +0100
X-Mailer: BrassMonkey/35.0.2
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <298e965b-6de2-43b6-a6c0-e844b115438b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 09:50, Shrikanth Hegde wrote:
>
>
> On 11/25/26 2:16 PM, Christian Zigotzky wrote:
>> On 06 November 2026 at 07:09 am, Shrikanth Hegde wrote:
>>
>> Hi Christian.
>>
>> We had one known issue which michal had brought up.
>> Do you have tracing enabled or running a bpf/bcc program?
>>
>> - - -
>>
>> Yes, we have BPF and Tracing activated in the kernel config.
>>
>> Nemo kernel config: 
>> https://github.com/chzigotzky/kernels/blob/main/configs/x1000_defconfig
>>
>> Edit: I have deactivated tracing
>>
>> Link: https://github.com/chzigotzky/kernels/releases/tag/v7.4.0-rc4-3
>
> If possible, please share the logs. Lets see if it gives any clues. Is 
> it while system is idle
> or running some workload?

It occurs sporadically during workloads. Disabling tracing did not solve 
the issue.

Log: 
https://github.com/user-attachments/files/35445406/Nemo_kernel_preempt_with_stack_issue.log

Link to the bug report: https://github.com/chzigotzky/kernels/issues/22

-- Christian

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


