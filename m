Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A9D922C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 17:04:44 +1000 (EST)
Message-ID: <517783D8.6010701@asianux.com>
Date: Wed, 24 Apr 2013 15:03:52 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC: kernel: memory access violation when
 rtas_data_buf contents are more than 1026
References: <516F7A7D.60206@asianux.com> <1366677081.2886.7.camel@pasglop>
 <5175E85F.1040509@asianux.com> <5175FC36.4060308@asianux.com>
 <51777B74.8040204@linux.vnet.ibm.com>
In-Reply-To: <51777B74.8040204@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013年04月24日 14:28, Vasant Hegde wrote:
> On 04/23/2013 08:42 AM, Chen Gang wrote:
>>
>> need set '\0' for 'local_buffer'.
>>
>> SPLPAR_MAXLENGTH is 1026, RTAS_DATA_BUF_SIZE is 4096. so the contents of
>> rtas_data_buf may truncated in memcpy.
>>
>> if contents are really truncated.
>>    the splpar_strlen is more than 1026. the next while loop checking will
>>    not find the end of buffer. that will cause memory access violation.
>>
> 
> Per parameter length in ibm,get-system-parameter RTAS call is limited to
> 1026 bytes (1024 bytes of data + 2 bytes  length). And 'rtas_data_buf'
> was set to 0 (first 1026 bytes) before call RTAS call. At the worst if
> we get junk in RTAS output length field helps to exit from the while
> loop. So I don't think we need this patch.

Is get-system-parameter return the NUL terminated string ? if so, it
will no issue (just like your discription).

If it will not return NUL terminated string, please see line 326:

  "while ((*local_buffer) && (idx < splpar_strlen))"
  (when idx == 1024, *local_buffer is memory access violation).

Since we use the first 2 bytes as length, and also be sure of the real
length will never more than 1024, I suggest to:

---------------------------patch begin--------------------------------

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 801a757..f8bd7cf 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -323,7 +323,7 @@ static void parse_system_parameter_string(struct seq_file *m)
 
 		w_idx = 0;
 		idx = 0;
-		while ((*local_buffer) && (idx < splpar_strlen)) {
+		while (idx < splpar_strlen) {
 			workbuffer[w_idx++] = local_buffer[idx++];
 			if ((local_buffer[idx] == ',')
 			    || (local_buffer[idx] == '\0')) {

---------------------------patch end----------------------------------

Thanks.

-- 
Chen Gang

Asianux Corporation
