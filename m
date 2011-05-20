Return-Path: <kazutomo.yoshii@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF2D5B71C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 11:32:20 +1000 (EST)
Received: by iym7 with SMTP id 7so2995952iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 18:32:17 -0700 (PDT)
Message-ID: <4DD5C49E.4050103@gmail.com>
Date: Thu, 19 May 2011 20:32:14 -0500
From: Kazutomo Yoshii <kazutomo.yoshii@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [bg-linux] [PATCH 5/7] [RFC] force 32-byte aligned kmallocs
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>	<1305753895-24845-5-git-send-email-ericvh@gmail.com>
	<1305851769.7481.90.camel@pasglop>
In-Reply-To: <1305851769.7481.90.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------030006080506050206070601"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030006080506050206070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/19/2011 07:36 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
>    
>> For BGP, it is convenient for 'kmalloc' to come back with 32-byte
>> aligned units for torus DMA
>>
>> Signed-off-by: Eric Van Hensbergen<ericvh@gmail.com>
>> ---
>>   arch/powerpc/include/asm/page_32.h |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
>> index 68d73b2..fb0a7ae 100644
>> --- a/arch/powerpc/include/asm/page_32.h
>> +++ b/arch/powerpc/include/asm/page_32.h
>> @@ -9,7 +9,7 @@
>>
>>   #define VM_DATA_DEFAULT_FLAGS	VM_DATA_DEFAULT_FLAGS32
>>
>> -#ifdef CONFIG_NOT_COHERENT_CACHE
>> +#if defined(CONFIG_NOT_COHERENT_CACHE) || defined(CONFIG_BGP)
>>   #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
>>   #endif
>>      
> Is DMA cache coherent on BG/P ? That's odd for a 4xx base :-)
>    

Actually DMA sends invalidate requests to the snoop unit(L2 level).
BGP SoC is a bit different from other 4xx base.

Some details can be found in
www.scc.acad.bg/documentation/team.pdf

- kaz

> Cheers,
> Ben.
>
>
>
> _______________________________________________
> bg-linux mailing list
> bg-linux@lists.anl-external.org
> https://lists.anl-external.org/mailman/listinfo/bg-linux
> http://bg-linux.anl-external.org/wiki
>    


--------------030006080506050206070601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
On 05/19/2011 07:36 PM, Benjamin Herrenschmidt wrote:
<blockquote cite="mid:1305851769.7481.90.camel@pasglop" type="cite">
  <pre wrap="">On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">For BGP, it is convenient for 'kmalloc' to come back with 32-byte
aligned units for torus DMA

Signed-off-by: Eric Van Hensbergen <a class="moz-txt-link-rfc2396E" href="mailto:ericvh@gmail.com">&lt;ericvh@gmail.com&gt;</a>
---
 arch/powerpc/include/asm/page_32.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 68d73b2..fb0a7ae 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -9,7 +9,7 @@
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_DEFAULT_FLAGS32
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
+#if defined(CONFIG_NOT_COHERENT_CACHE) || defined(CONFIG_BGP)
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 #endif
    </pre>
  </blockquote>
  <pre wrap="">
Is DMA cache coherent on BG/P ? That's odd for a 4xx base :-)
  </pre>
</blockquote>
<br>
Actually DMA sends invalidate requests to the snoop unit(L2 level).<br>
BGP SoC is a bit different from other 4xx base. <br>
<br>
Some details can be found in<br>
<span class="f"><cite><a class="moz-txt-link-abbreviated" href="http://www.scc.acad.bg/documentation/team.pdf">www.scc.acad.bg/documentation/team.pdf</a></cite></span>
<br>
<br>
- kaz<br>
<br>
<blockquote cite="mid:1305851769.7481.90.camel@pasglop" type="cite">
  <pre wrap="">
Cheers,
Ben.



_______________________________________________
bg-linux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:bg-linux@lists.anl-external.org">bg-linux@lists.anl-external.org</a>
<a class="moz-txt-link-freetext" href="https://lists.anl-external.org/mailman/listinfo/bg-linux">https://lists.anl-external.org/mailman/listinfo/bg-linux</a>
<a class="moz-txt-link-freetext" href="http://bg-linux.anl-external.org/wiki">http://bg-linux.anl-external.org/wiki</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------030006080506050206070601--
