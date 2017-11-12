Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZglL6ySRzDsTK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 04:30:22 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vACHTF0b023379
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 12:30:19 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e6f1bqfec-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 12:30:18 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sun, 12 Nov 2017 17:30:16 -0000
Subject: Re: [PATCH 2/2] powerpc/fadump: use kstrtoint to handle sysfs store
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Colin Ian King <colin.king@canonical.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20170626140601.7106-1-msuchanek@suse.de>
 <20170626140601.7106-2-msuchanek@suse.de>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Sun, 12 Nov 2017 23:00:03 +0530
MIME-Version: 1.0
In-Reply-To: <20170626140601.7106-2-msuchanek@suse.de>
Content-Type: multipart/alternative;
 boundary="------------37F9105DF9F86044BD4E0FD9"
Message-Id: <91670617-7a85-22b7-acc9-b654aba22e06@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------37F9105DF9F86044BD4E0FD9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the patch, Michal.


On Monday 26 June 2017 07:36 PM, Michal Suchanek wrote:
> Currently sysfs store handlers in fadump use if buf[0] == 'char'.
>
> This means input "100foo" is interpreted as '1' and "01" as '0'.
>
> Change to kstrtoint so leading zeroes and the like is handled in
> expected way.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

> ---
>   arch/powerpc/kernel/fadump.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 5a7355381dac..241eff0b5f76 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1161,10 +1161,15 @@ static ssize_t fadump_release_memory_store(struct kobject *kobj,
>   					struct kobj_attribute *attr,
>   					const char *buf, size_t count)
>   {
> +	int input = -1;
> +
>   	if (!fw_dump.dump_active)
>   		return -EPERM;
>
> -	if (buf[0] == '1') {
> +	if (kstrtoint(buf, 0, &input))
> +		return -EINVAL;
> +
> +	if (input == 1) {
>   		/*
>   		 * Take away the '/proc/vmcore'. We are releasing the dump
>   		 * memory, hence it will not be valid anymore.
> @@ -1198,21 +1203,25 @@ static ssize_t fadump_register_store(struct kobject *kobj,
>   					const char *buf, size_t count)
>   {
>   	int ret = 0;
> +	int input = -1;
>
>   	if (!fw_dump.fadump_enabled || fdm_active)
>   		return -EPERM;
>
> +	if (kstrtoint(buf, 0, &input))
> +		return -EINVAL;
> +
>   	mutex_lock(&fadump_mutex);
>
> -	switch (buf[0]) {
> -	case '0':
> +	switch (input) {
> +	case 0:
>   		if (fw_dump.dump_registered == 0) {
>   			goto unlock_out;
>   		}
>   		/* Un-register Firmware-assisted dump */
>   		fadump_unregister_dump(&fdm);
>   		break;
> -	case '1':
> +	case 1:
>   		if (fw_dump.dump_registered == 1) {
>   			goto unlock_out;
>   		}



--------------37F9105DF9F86044BD4E0FD9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Thanks for the patch, Michal.<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On Monday 26 June 2017 07:36 PM, Michal
      Suchanek wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20170626140601.7106-2-msuchanek@suse.de">
      <pre wrap="">Currently sysfs store handlers in fadump use if buf[0] == 'char'.

This means input "100foo" is interpreted as '1' and "01" as '0'.

Change to kstrtoint so leading zeroes and the like is handled in
expected way.

Signed-off-by: Michal Suchanek <a class="moz-txt-link-rfc2396E" href="mailto:msuchanek@suse.de">&lt;msuchanek@suse.de&gt;</a></pre>
    </blockquote>
    <br>
    Acked-by: Hari Bathini <a class="moz-txt-link-rfc2396E"
      href="mailto:hbathini@linux.vnet.ibm.com">&lt;hbathini@linux.vnet.ibm.com&gt;</a><br>
    <br>
    <blockquote type="cite"
      cite="mid:20170626140601.7106-2-msuchanek@suse.de">
      <pre wrap="">
---
 arch/powerpc/kernel/fadump.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 5a7355381dac..241eff0b5f76 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1161,10 +1161,15 @@ static ssize_t fadump_release_memory_store(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					const char *buf, size_t count)
 {
+	int input = -1;
+
 	if (!fw_dump.dump_active)
 		return -EPERM;

-	if (buf[0] == '1') {
+	if (kstrtoint(buf, 0, &amp;input))
+		return -EINVAL;
+
+	if (input == 1) {
 		/*
 		 * Take away the '/proc/vmcore'. We are releasing the dump
 		 * memory, hence it will not be valid anymore.
@@ -1198,21 +1203,25 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 					const char *buf, size_t count)
 {
 	int ret = 0;
+	int input = -1;

 	if (!fw_dump.fadump_enabled || fdm_active)
 		return -EPERM;

+	if (kstrtoint(buf, 0, &amp;input))
+		return -EINVAL;
+
 	mutex_lock(&amp;fadump_mutex);

-	switch (buf[0]) {
-	case '0':
+	switch (input) {
+	case 0:
 		if (fw_dump.dump_registered == 0) {
 			goto unlock_out;
 		}
 		/* Un-register Firmware-assisted dump */
 		fadump_unregister_dump(&amp;fdm);
 		break;
-	case '1':
+	case 1:
 		if (fw_dump.dump_registered == 1) {
 			goto unlock_out;
 		}
</pre>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------37F9105DF9F86044BD4E0FD9--
