Return-Path: <joro-2013@t-online.de>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD1631A0179
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 03:23:27 +1100 (EST)
Message-ID: <543BFC6C.10701@t-online.de>
Date: Mon, 13 Oct 2014 18:23:08 +0200
From: Jochen Rollwagen <joro-2013@t-online.de>
MIME-Version: 1.0
To: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: powerpc32: add support for csum_add()
References: <543AAADB.1070304@t-online.de> <543BB4CB.6030105@c-s.fr>
In-Reply-To: <543BB4CB.6030105@c-s.fr>
Content-Type: multipart/alternative;
 boundary="------------080308010400080006060607"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080308010400080006060607
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2014 um 13:17 schrieb leroy christophe:
> Le 12/10/2014 18:22, Jochen Rollwagen a écrit :
>> This patch
>>
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121144.html
>>
>> only compiles after putting an #ifndef ARCH_HAS_CSUM_ADD around the 
>> definition in include/net/checksum.h
>>
>> This is missing from the patch
>>
>>
>
> This is already included upstream since May 2014, see patch below
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=07064c6e022ba8dc0c86ce12f7851a1de24e04fc
>
>  From 07064c6e022ba8dc0c86ce12f7851a1de24e04fc Mon Sep 17 00:00:00 2001
> From: Tom Herbert<therbert@google.com>
> Date: Fri, 2 May 2014 16:28:03 -0700
> Subject: net: Allow csum_add to be provided in arch
>
> csum_add is really nothing more then add-with-carry which
> can be implemented efficiently in some architectures.
> Allow architecture to define this protected by HAVE_ARCH_CSUM_ADD.
>
> Signed-off-by: Tom Herbert<therbert@google.com>
> Signed-off-by: David S. Miller<davem@davemloft.net>
>
> diff --git a/include/net/checksum.h b/include/net/checksum.h
> index a28f4e0..87cb190 100644
> --- a/include/net/checksum.h
> +++ b/include/net/checksum.h
> @@ -57,12 +57,14 @@ static __inline__ __wsum csum_and_copy_to_user
>   }
>   #endif
>   
> +#ifndef HAVE_ARCH_CSUM_ADD
>   static inline __wsum csum_add(__wsum csum, __wsum addend)
>   {
>   	u32 res = (__force u32)csum;
>   	res += (__force u32)addend;
>   	return (__force __wsum)(res + (res < (__force u32)addend));
>   }
> +#endif
>   
>   static inline __wsum csum_sub(__wsum csum, __wsum addend)
>   {
> -- 
> cgit v0.10.1
>
>
Ah bon. Obviously this wasn't backported to 3.14, that's what i compiled 
for. So i backported the 2 Lines of code manually et tout est bon.

Salut

Jochen

--------------080308010400080006060607
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 13.10.2014 um 13:17 schrieb leroy
      christophe:<br>
    </div>
    <blockquote cite="mid:543BB4CB.6030105@c-s.fr" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      Le 12/10/2014 18:22, Jochen Rollwagen a écrit :<br>
      <blockquote cite="mid:543AAADB.1070304@t-online.de" type="cite">
        <meta http-equiv="content-type" content="text/html;
          charset=utf-8">
        This patch<br>
        <br>
        <span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black"><a
            moz-do-not-send="true" class="moz-txt-link-freetext"
href="https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121144.html">https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121144.html</a><br>
          <br>
          only compiles after putting an #ifndef ARCH_HAS_CSUM_ADD
          around the definition in include/net/checksum.h<br>
          <br>
          This is missing from the patch<br>
        </span> <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
      </blockquote>
      <br>
      This is already included upstream since May 2014, see patch below<br>
      <br>
      <a moz-do-not-send="true"
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=07064c6e022ba8dc0c86ce12f7851a1de24e04fc">https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=07064c6e022ba8dc0c86ce12f7851a1de24e04fc</a><br>
      <br>
      <pre style="color: rgb(0, 0, 0); font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; white-space: pre-wrap;">From 07064c6e022ba8dc0c86ce12f7851a1de24e04fc Mon Sep 17 00:00:00 2001
From: Tom Herbert <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:therbert@google.com">&lt;therbert@google.com&gt;</a>
Date: Fri, 2 May 2014 16:28:03 -0700
Subject: net: Allow csum_add to be provided in arch

csum_add is really nothing more then add-with-carry which
can be implemented efficiently in some architectures.
Allow architecture to define this protected by HAVE_ARCH_CSUM_ADD.

Signed-off-by: Tom Herbert <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:therbert@google.com">&lt;therbert@google.com&gt;</a>
Signed-off-by: David S. Miller <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:davem@davemloft.net">&lt;davem@davemloft.net&gt;</a>

diff --git a/include/net/checksum.h b/include/net/checksum.h
index a28f4e0..87cb190 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -57,12 +57,14 @@ static __inline__ __wsum csum_and_copy_to_user
 }
 #endif
 
+#ifndef HAVE_ARCH_CSUM_ADD
 static inline __wsum csum_add(__wsum csum, __wsum addend)
 {
 	u32 res = (__force u32)csum;
 	res += (__force u32)addend;
 	return (__force __wsum)(res + (res &lt; (__force u32)addend));
 }
+#endif
 
 static inline __wsum csum_sub(__wsum csum, __wsum addend)
 {
-- 
cgit v0.10.1
</pre>
      <br class="Apple-interchange-newline">
      <br>
    </blockquote>
    Ah bon. Obviously this wasn't backported to 3.14, that's what i
    compiled for. So i backported the 2 Lines of code manually et tout
    est bon.<br>
    <br>
    Salut<br>
    <br>
    Jochen<br>
  </body>
</html>

--------------080308010400080006060607--
