Return-Path: <linuxppc-dev+bounces-26152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67E5C61DC4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 16:39:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hW6fz6RdBz2y2L;
	Fri, 28 Aug 2026 02:39:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.82 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787848763;
	cv=pass; b=VCedV5OfJ+TU+LAvKcA7n+EXKqnDnXVbUy9yOhzfowUsD1NgWFXiYjkeNGGX7N/R2j9oDqUtMf8sau/ECzrYKtExotV6V7D5PKWNyrQ7CwbGtKu46D5MQOD8xC92sH8223zhOkhx1MRigbxjlG7BQeTLXZgOYjYAmKji120dCa1eLOvJtYRJFF2wiUvPHbk72CwxayuooX9vJwWAPrtvlIA6FEkpENrQFvkpggWQEkIRX4TbffeN4SUH+1dmj0/Kb2lDw9fl9FjSpWcMpQnA/fKG56+tI8EYWXwZnnwGD2OOpuRwioswAyy5x/4sd+JyoblbXo9OcaP+oQyMMYiaSg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787848763; c=relaxed/relaxed;
	bh=GUXiJgGIzMonMQ0jFqGt4XanZVvlY/u6PNP7jX3/x2c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bn5mSvWeFUu6k+IViFRGz2YijERf/Xc+TTZXxecZNv/7ssQ4Pi5ulcbhq25NdTcgiU7zDfIxoEaGrQrMkUi0bFEQCuclTWUhLoP6lmScVBUbUQhp/skeoJBjRIJsHD9KWLrYw+SW8FCw95OBvLwp30cKKwky72Qzjn14dH1W5EOpW5X26ZrU2gPjPdk+O0DlhV/sh4WbR67rVKEuQCwSVyWudq2H6VVY2bf2ymmRhMIPIaTiopK4OAvWCFkLHXvR8j98o4dgakYXnLOjZNMsU+vOk27xfYhe/qwU6k/41PaNwA3eCsoU5kY22g/tWViiSphgcwwjZk0ay9BTgzKu3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jO7Exppb; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eU8etFKP; dkim-atps=neutral; spf=pass (client-ip=85.215.255.82; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jO7Exppb;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eU8etFKP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=85.215.255.82; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hW6fs1rQjz2xtt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 02:39:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1787848740; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LoJajNR14YIyhaidCQuecyWEWnWNyHiMJKLT9Uw0sRI6uSBexBUmteHjlA5PIjDsDm
    dtkzj7BCF0hTc/MObSspQskdtmwiKO4UTDN4BvdkDuUs5BEUcYiyVOs6aEg57mID3/RF
    BbCQOPUM77wCG4/OHH2nkAsefKtuv2XW13PMRKInZ1yuA65wybKu2QyAaDRa6eoWXmBx
    iEjuWpRj8LHuQYfl0YICpmi4xTbHnZpnaDplGH9D43jTEneJUV8HIsjyvqJFvacF6W4U
    W6/yjL14RIUfjT5lH/kCvsoLqwnFDSMXzVTK5Iehpy9GWYgQr7exsGW4jP+mxE++ursL
    pHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787848740;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GUXiJgGIzMonMQ0jFqGt4XanZVvlY/u6PNP7jX3/x2c=;
    b=nFzfnQIPivykQpMi/R49IVFUsi63iyeG0sa1HQA16QOFOKs6XDsY3nrOwVJ8QXg8nM
    hzXqMCLSC8R7CYTLqG1he1tcS0yABXJvkGUaZxuzCqFq5uk8JltAdeBYiGliodT0WWHs
    wn96rB0LDNfsqitCVmj2PJVrJ0RkTSbZ13y3ohVj8kDjYn7iN+Y+Ty4VfuOu2DPU2rw0
    cytbwjMVf/p5h4cq/ung3/NITaMkJlFUP9Obm/UpoGZ6nEiQ2wJd9ItDC8YAMEy+HNh5
    g8kKZNTkFu0DIP8M82eaFhR8H+D6X0YyEU5YpWeaAU69vmUn5sK63VjGLQw521x2aj7P
    IcQA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787848740;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GUXiJgGIzMonMQ0jFqGt4XanZVvlY/u6PNP7jX3/x2c=;
    b=jO7ExppbfWeTflltT44L1n5bj61Ubr/rMC62y/Zi/S/ZT9sMKGs5TdRDIVG20+sUMC
    23/yBfAcQCxVvrfYaZp6f5BEzGmPwl7mvY0c9JuG47X0alkU5d+N9rUePt3KLp5Ay6rj
    uDj5I3xdgo9ZWwTAGa0D40KH2P/XEmjqC8yPWpJWItOIQr+TiJSSDqgXgayF4MaF0cNS
    M6fr6EDSa5vdjUF5WYTDupiQ1KUmz6BhjUT55frZB6H3ADm+TZNVyEvkMNaX1eF0CY0r
    xmKYA05gPOq/+T3D+NosqLC8YP4lQylnozlBjcNVdcYwPjEJIEC4mItJ4tKzbsqso4Iz
    eEiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787848740;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GUXiJgGIzMonMQ0jFqGt4XanZVvlY/u6PNP7jX3/x2c=;
    b=eU8etFKPAAFFSH+4mFQqGS6IeTAcNjMxBYYEStmXgStckrrvLgYuDyUwRtwwmw4a+L
    U8wK9vVzeCFQCnzg+8BA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+s7Xc="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee27RGcxWWW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Aug 2026 18:38:59 +0200 (CEST)
Subject: Re: drm/mgag200: Fix big-endian support
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: rene@exactco.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <1fe9c172-c12c-4827-b9a5-2870c45e67af@suse.de>
 <A1B9BBC7-0CBA-45DC-8DA1-EEC6776CDA62@xenosoft.de>
 <4ba35195-5421-4c52-bbe5-ed88e15e394d@suse.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <8ff12e31-2677-c554-cc3d-1bade8138876@xenosoft.de>
Date: Thu, 27 Aug 2026 18:38:59 +0200
X-Mailer: BrassMonkey/34.3.2.1
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <4ba35195-5421-4c52-bbe5-ed88e15e394d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/08/26 08:36, Thomas Zimmermann wrote:
> Hi
>
> Am 26.08.26 um 19:30 schrieb Christian Zigotzky:
>> On 26 August 2026 at 05:23 pm, Thomas Zimmermann 
>> <tzimmermann@suse.de> wrote:
>>
>> ﻿Hi
>>
>> Could be that we have to enable access to the ROM first. That's why 
>> it returns only 0xffff. Does the card display output when you switch 
>> on the computer?
>>
>> Best regards
>> Thomas
>>
>> - - -
>>
>> Hello Thomas,
>>
>> No, the card doesn’t display output when I switch on the computer.
>
> Attached you'll find another patch that also enables ROM access in the 
> PCI config options.  I took the code out of the old matroxfb driver 
> without further testing. Please try and report back on the results.
>
> Best regards
> Thomas
>

Hello Thomas,

Thank you for your effort to solve the problem. Unfortunately, your new 
patch doesn't solve the problem either. The error outputs are the same 
as before.

Cheers,
Christian

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


