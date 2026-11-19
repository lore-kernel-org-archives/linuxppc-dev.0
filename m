Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775A606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=JRdDZEM1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVZGH2b8kz2xSF;
	Thu, 19 Nov 2026 21:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=62.149.156.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795083591;
	cv=none; b=iC83epSgi63mBjff3Zd+/spPESSj+NgQVR31g7SITa5xjysrgPpRmikbF8Vaic0sxAjUodP7Ab01KbRiRhTEVZWYa+dF36BN2zTaDsW2aNDXVU309v2sDdCmwZl530K70wwAZhiMWNdwPFn73/uMmojLkCY4emrdScMND/p8brKuU7BL/j75vdM4Goqx+FPu1C3MY56+t9fIZf9lXW/b5pERNRtDmYGElFi+LLNE1y908ozYqy+c2w9C3O3K01hEj26TAiF1RqEBiboX+AduOucSjcljfVMSlK1pFKqu+4cE+AInKOYsmvaX6/SPO0uXeQbfMO09+IeBoQARc9yIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795083591; c=relaxed/relaxed;
	bh=vxF6EachACi14PY9ozrbae5qo5jIjGyvh8VwxPiTjtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJEnkl65PiLYzSWVi15bU2N94MsdOPMWfMU4SwdTO0rHXa3O4yqK0MX24EtNmR8Wv3h+oqFwlkqrmXTW4ec0XwfDZo1TE3J4M4CUwoJHPDbokdQjr6vwplfCcuhE3KTafJwSL2So2whv45Jum32XqAJngYOmWeDY0QSc5Q3YcJqoF9Lwp1MqheCJld9zmf3JZgA7OhFVsQs6vd5ILXEYGeGQ+5Zeq14gpY4/D9oAnWfBGRHpUaKhlkLx1TtcUxJVOm5iPNVENN0eeKpMXGGW1ehUrJKSNUxCrR9IdORHPG8JWymOzFGPPGbZoQQG4WHmgpcM3QUV6GbpKkaGMB1KvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=JRdDZEM1; dkim-atps=neutral; spf=pass (client-ip=62.149.156.116; helo=smtpcmd11116.aruba.it; envelope-from=giometti@enneenne.com; receiver=lists.ozlabs.org) smtp.mailfrom=enneenne.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=JRdDZEM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=enneenne.com (client-ip=62.149.156.116; helo=smtpcmd11116.aruba.it; envelope-from=giometti@enneenne.com; receiver=lists.ozlabs.org)
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVZGD0kycz2xQK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 21:19:46 +1100 (AEDT)
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id TzDwxCivc6VShTzDwxQnb6; Thu, 19 Nov 2026 11:18:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1795083518; bh=aRc2mUQAMNF1zYaxkS0G15m7lGbkHwkBf36QtSll1JI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=JRdDZEM1FxuLixVNZ93BzrJfxnVP/26ipIlHN+dp61SIDQlEQQop3o7sRPTCaTyPS
	 rEay+jZzRTrnxEK0zIPwaMeKVAy3ZAJ4VSQUpUXySdP/ZTuPPa0VTySV40cWcpYl/i
	 S2JPpoWNlrAeMVzaV315uHz1J6YigtiMU5Wtqsp450GlhhhX/GyktfzXt5dwFWoZUm
	 HWLJnzLs5kW2Uj3Rt4AaM+Iv7+JwtiWWYhNFbx91v7byIKfcN7B9iIz9lu6wIVI2uZ
	 aN8cHrCXdLEOj1XTbIELAWsvQb4tvcfjY3NvHr7VuatOojMKu2K095m2lBR3n4bmLD
	 GFVq9L0+t/Kow==
Message-ID: <3929b9f6-6c75-4118-8565-0fa815daad73@enneenne.com>
Date: Thu, 19 Nov 2026 11:18:35 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
 <sahil.malhotra@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Richard Weinberger <richard@nod.at>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>,
 Demi Marie Obenour <demiobenour@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20261118140421.584086-1-giometti@enneenne.com>
 <mvyqqjhvfka3kkumztixzozrthutkq6mfakkonxqbpm5gvzb62@eitzzleeyioe>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <mvyqqjhvfka3kkumztixzozrthutkq6mfakkonxqbpm5gvzb62@eitzzleeyioe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPjnEm0KRtHAk7Xu1+wSM4ggxCt0j1Q9+oPLJi/gROcWWTrg+bgdMN95hJiGJBFhXNd6tGxHzy6xI0wdizsmJC4J007C4HZ7TjGFtLcp5Xb8cbyhKvCM
 Uzi07n/ZVC55gl/w9PVaRMiTc3bcpg7tO05693rsuDxzyWOix/VwRUOBhu1IueXjgkym+5pWn1ALjtRadwrLMRdaeSsJDiVh2ZQca0aoz4u7G/gCZQ5faMsr
 ZbtImVL6pGG0os0vzUhZoUoOYpQPmsGag1CbEOAQmLosnRs3OlfqWoAerckw6+IMg/RhJ2Eqo25H29DY9g+9jqF0sRCX2cGsed1zipjVQIv107xJ4oWajlMV
 khd+68I3cGge4Vn8ffNyLMkKKo/iJL/DNFFERF5Xakxk9jeQ1HM6duQORfrCdoY1+r8sEyvhQ/pV+NHocBjmHdx8pOOJz1IB6ViJUjggNpQ4pShQJ/Q0UioG
 IhxEvjeG/QWEA24O0wocRyCijL5a2PS+26ayplel3SFPR3QFQ78J/d5ndiwPhgD97VXhsJ21Oh6X7XhAuPBfd3vRgWNmsIXv0v3kcvvMkgBG6p+6iL3Pxl/x
 zavj84ZHUgLKZe6f1tIP5SJ1YyiTyHA1gZEUCVUrz+Cx1+ovBDp41C0+Tgh/TGV4+VzONZHmBN0PxjOcZMxCSHjE1ah9po0YrQdl7HncKrIofFRZWo3TaiN1
 AnpZYBtmoIVWG5AplanALkXXkv9Zs/27M2XlGOUHeaKmTURpTQQr4hsshpVDhQNrneeSlqfvQqqPnrI4xqEIHpYAYYvdZeMANJjibaJ9mC4v6nqc1Bs+KRG2
 jPkbn8KFBW7GbgfStZw917JtIBvEl6o76lQaHbEgtff8DHMJeGoZE71fqFn0JiGSt6EInCz15aMu6GfXfOqmM+19YtIuslmqlsHAL293EHy97V6+H4tud7on
 +EE6whsmEew7X2WFgAmj9MCDrlU7j/BWptczETpDpe1q+Ii4p49RTfBYxWATznipdt0Be9TcrlrSDmhipimKEIXDdPxn8Xopaf3Aci3FLX8b8rhQB6Y74bYO
 juodC91CjWzTz/WjX25ga1p4q+NdG2JyM0Nl/WTr+MzBTDhumuqGKwWXiAEw1hR0ErwXJ9rSCyoOWdXXIZkLYBTXUFfVLXLMnd7NefRGBM9W6EP6GYPqVsIU
 n+BzVDWKBf0t3eOT+SK7VteJdFVad5smIFK5PmcTex31jZ6ojvJLxT++uqvnxnj0DNZ8ZH0wHYXggM4S9WepwdbJ93fO0vAIYYdgVBZEnbHghoP6l3JZCQ8u
 +VYxcC/6t+H9Iwr0dfEQelnD5aSSELDw+McFe47W2bPEVApk2DO7csk6K6D+fTQa41wkTVX1
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18/11/2026 15:57, Marco Felsch wrote:
> Hi Rodolfo,

Hi.

> thanks for the RFC and bringing this up. Please see my comments below.

Thanks to you for reading it!

> On 26-11-18 15:04, Rodolfo Giometti wrote:
>> This RFC proposes a key type, "keycrypt", whose material user space can
> 
> Albeit I'm not against a new key-type we already have plenty types.
> 
> Furthermore the keyctl API is very open, lacks a common API. E.g. for the
> 'trusted-key' keytype userspace needs to know the actual used backend
> because each backend handles it differently.
> 
> Therefore I wouldn't add further keytypes till we have a common API
> which the userspace can rely on.

I agree that a common API is missing. keycrypt is meant to be one, for
keys that user space uses but never reads: the same ioctls on the fd
for every backend, and the same add_key() strings but for the sw
backend's master=, so user space does not need to know which backend
holds the key (unless it asks for one with backend=). What is missing
is a way to ask which backends and algorithms exist (see below).

[snip]

> So it's not a new keytype but a new mechanism to handle trusted-keys
> from userspace?

No, a keycrypt key is not a trusted key. Only the sw backend uses a
trusted key, as the master that seals its blobs; the OP-TEE and CAAM
backends use none. Also, an ELE backend, not written yet, would use
none, and it could be the first hsm backend!

[snip]

>> An embedded product that encrypts its own data (a root filesystem
>> archive, configuration backups, logs) needs a key that does not sit in
>> the root filesystem and that a compromised user space cannot copy. Today
> 								^
> 					What exactly do you mean by copy?
> 
> If you're using the standard LUKS2 scheme, the (volume)key never sits
> inside encrypted device. The key is part of the LUKS2 header. Maybe I
> didn't got your use-case, can you please elaborate a bit more?

By copy I mean getting the key's bytes to use them elsewhere. A user
key can be read back; a logon key cannot, but its bytes come from user
space at every boot, so they sit in a file. A trusted or encrypted key
fixes that, and the cover letter was wrong there: AF_ALG can use one
from user space. But, as you note below, once unsealed its bytes are
in kernel memory, so it falls with the kernel, and nothing binds it to
an algorithm or a purpose.

My use case is not a block device: it is files that an application
encrypts itself (an archive of the root filesystem, configuration
backups, logs), with a key that must not be readable on the device and
that ideally may only encrypt, or only decrypt.

You can see keycrypt keys as the symmetric counterpart of the
asymmetric keys that KEYCTL_PKEY_* already lets user space use without
reading them. The difference is that a symmetric mode keeps state
across calls (the CBC chain, a stream's segments), hence an fd instead
of one keyctl call per operation. And, as for KEYCTL_PKEY_*, the open
could become a key_type operation, so that keyctl knows no key type.

[snip]

> Above you mentioned trusted-keys, but trusted-keys don't let the key
> stay inside the TEE. Albeit the key is only reachable kernel (EL1) it is
> always reachable from normal world. So a kernel CVE could leak the key
> as well. This is different compared to protected keys like
> p(rotected)aes. Here the keys always stay within firmware/secure-world.

Yes. With the OP-TEE backend a generated key never leaves the TA,
which runs the operation, and the kernel only holds a blob it cannot
open, so even a compromised kernel can only use the key, and only for
what it was sealed for. An hsm backend, as ELE could become, would do
the same in dedicated hardware.

> I didn't get your problem from your above description, sorry and
> therefore I'm asking.
> Do you want to use trusted-keys for partition (rootfs, data, ...)
> encryption? In such case I've developed another idea which I'm about to
> post as RFC.

No, file encryption from user space, as above. In one sentence:
keycrypt gives the keyring keys that user space can use but never
read, bound to one algorithm and purpose; with a TEE backend they are
never in clear in the kernel either, and they work from a minimal
initramfs, before any user-space crypto stack exists.

That last part matters a lot on embedded systems. The initramfs
usually sits in the FIT image that the secure-boot chain must
authenticate, and often decrypt, before running it, so it must be as
small as possible (on our i.MX93 boards this runs at about 2.4MiB/s
through ELE). In such an initramfs, OP-TEE's PKCS#11 TA would also need
secure storage set up before the root filesystem (tee-supplicant with
a writable filesystem, or a provisioned RPMB); keycrypt's OP-TEE
backend needs no storage and no daemon, just the keyctl syscall and a
small tool driving the fd.

[snip]

>> 1. A key type, "keycrypt", created with add_key() from "new <alg>
>>    <purposes> [tier=|min-tier=] [backend=]", "load <blob>
>>    [accepted-min-tier=] [purpose=]" or, when allowed, "import <alg>
>>    <purposes> [tier=|min-tier=] [backend=] <hex>". User space states the
> 
> This is exactly what I meant at the begining. I'm not a maintainer, but
> this string parsing "API" is very error-prone. Furthermore, how can a
> userspace enum available backends? Instead of try and error I would like
> to see a query/enum phase and later on userspace can decide which
> backend and tier to use.

The strings follow what trusted and encrypted keys already take in
add_key(), but I'm open to another form, such as a versioned binary
struct like the one KEYCTL_CRYPT_OPEN already takes with
copy_struct_from_user().

On the enumeration you're right, there is none: a key's line in
/proc/keys and KEYCRYPT_IOC_INFO on an open fd tell its backend and
tier only after the fact. A list of the backends, with their tier and
algorithms, would be easy to add, and it is needed since algorithms
differ per backend (the CAAM one does aes256-cbc only): would a keyctl
or a file under /proc be what you have in mind?

[snip]

>>   tier     key in clear    purpose enforced by   who may use the key
>>            in the kernel
>>   kernel   yes             the kernel            the kernel
> 
> These are basically the trusted-key purpose.

Yes, the kernel tier gives the protection of a trusted key, and it does
not meet the goal above. It is there only so that the same interface
works on systems with nothing better; its only backend, sw, is
optional and off by default, and it can go if it is considered wrong.

>>   engine   no              the kernel            the kernel
>>   tee      no              the TA                the kernel
>>   hsm      no              the HSM               the kernel
> 
> These are protected keys which we have already (see S390, CAAM, DCP,
> Zynqmp, ...).
> 
> I don't see what you want to solve with your approach. Do you want to
> have a common interface for generating/loading protected keys?

Yes, and for using them from user space, with a purpose bound to each
key (encrypt-only, decrypt-only, verify-only) that the TA, or an HSM,
enforces. keycrypt does not replace the protected keys you name: a
backend is where such a key lives.

> That beeing said, loading protected keys can already be done by just
> specifying the correct key-cipher. Generating the key is platform
> specific and would need a common API.

For user space that means AF_ALG with cbc(paes) only (the CAAM,
CryptoCell and s390 register one AF_ALG can reach; DCP's is internal),
each driver with its own key format, and since v7.3 privileged by
default (d9506e82ced5). Generating is what "new" does in keycrypt:
with OP-TEE the TA generates the key itself. The CAAM patches are only
a prototype there: they still generate the key in kernel memory, and
the aim is to have the CAAM generate it and keep it black (one of the
questions to the CAAM maintainers in the cover letter).

> Thanks for sharing your ideas :)

:)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

