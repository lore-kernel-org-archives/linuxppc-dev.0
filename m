Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AE2B1A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 17:13:36 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C3CF14016B
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2015 17:13:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 16:13:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 615442CE8054
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2015 17:13:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t246DHFI28573924
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Mar 2015 17:13:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t246Cuh3028573
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Mar 2015 17:12:57 +1100
Message-ID: <54F6A258.2080402@linux.vnet.ibm.com>
Date: Wed, 04 Mar 2015 11:42:40 +0530
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 2/4] pstore: Add pstore type id for PPC64 opal nvram
 partition
References: <20150205193412.24669.8648.stgit@localhost.localdomain>
 <20150205193628.24669.79936.stgit@localhost.localdomain>
In-Reply-To: <20150205193628.24669.79936.stgit@localhost.localdomain>
Content-Type: multipart/alternative;
 boundary="------------040506030609070809090807"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040506030609070809090807
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2015 01:06 AM, Hari Bathini wrote:
> This patch adds a new PPC64 partition type to be used for opal
> specific nvram partition. A new partition type is needed as none
> of the existing type matches this partition type.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

This patch series is reviewed by Kees.
Reference link: https://lkml.org/lkml/2015/2/5/651

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks
Hari

> ---
>   fs/pstore/inode.c      |    3 +++
>   include/linux/pstore.h |    1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 5041660..8e0c009 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -359,6 +359,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
>   	case PSTORE_TYPE_PPC_COMMON:
>   		sprintf(name, "powerpc-common-%s-%lld", psname, id);
>   		break;
> +	case PSTORE_TYPE_PPC_OPAL:
> +		sprintf(name, "powerpc-opal-%s-%lld", psname, id);
> +		break;
>   	case PSTORE_TYPE_UNKNOWN:
>   		sprintf(name, "unknown-%s-%lld", psname, id);
>   		break;
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index ece0c6b..af44980 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -39,6 +39,7 @@ enum pstore_type_id {
>   	PSTORE_TYPE_PPC_RTAS	= 4,
>   	PSTORE_TYPE_PPC_OF	= 5,
>   	PSTORE_TYPE_PPC_COMMON	= 6,
> +	PSTORE_TYPE_PPC_OPAL	= 7,
>   	PSTORE_TYPE_UNKNOWN	= 255
>   };
>   
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------040506030609070809090807
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 02/06/2015 01:06 AM, Hari Bathini
      wrote:<br>
    </div>
    <blockquote
      cite="mid:20150205193628.24669.79936.stgit@localhost.localdomain"
      type="cite">
      <pre wrap="">This patch adds a new PPC64 partition type to be used for opal
specific nvram partition. A new partition type is needed as none
of the existing type matches this partition type.

Signed-off-by: Hari Bathini <a class="moz-txt-link-rfc2396E" href="mailto:hbathini@linux.vnet.ibm.com">&lt;hbathini@linux.vnet.ibm.com&gt;</a></pre>
    </blockquote>
    <br>
    This patch series is reviewed by Kees.<br>
    Reference link: <a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2015/2/5/651">https://lkml.org/lkml/2015/2/5/651</a><br>
    <br>
    Reviewed-by: Kees Cook <a class="moz-txt-link-rfc2396E" href="mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a><br>
    <br>
    Thanks<font face="sans-serif"><br>
      Hari</font><br>
    <pre itemprop="articleBody">
</pre>
    <blockquote
      cite="mid:20150205193628.24669.79936.stgit@localhost.localdomain"
      type="cite">
      <pre wrap="">
---
 fs/pstore/inode.c      |    3 +++
 include/linux/pstore.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5041660..8e0c009 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -359,6 +359,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 	case PSTORE_TYPE_PPC_COMMON:
 		sprintf(name, "powerpc-common-%s-%lld", psname, id);
 		break;
+	case PSTORE_TYPE_PPC_OPAL:
+		sprintf(name, "powerpc-opal-%s-%lld", psname, id);
+		break;
 	case PSTORE_TYPE_UNKNOWN:
 		sprintf(name, "unknown-%s-%lld", psname, id);
 		break;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index ece0c6b..af44980 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -39,6 +39,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_PPC_RTAS	= 4,
 	PSTORE_TYPE_PPC_OF	= 5,
 	PSTORE_TYPE_PPC_COMMON	= 6,
+	PSTORE_TYPE_PPC_OPAL	= 7,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 

_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040506030609070809090807--
