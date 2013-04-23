Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 49D812C0162
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 11:49:07 +1000 (EST)
Message-ID: <5175E85F.1040509@asianux.com>
Date: Tue, 23 Apr 2013 09:48:15 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Suggestion] PowerPC: kernel: memory access violation when
 rtas_data_buf contents are more than 1026
References: <516F7A7D.60206@asianux.com> <1366677081.2886.7.camel@pasglop>
In-Reply-To: <1366677081.2886.7.camel@pasglop>
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

On 2013年04月23日 08:31, Benjamin Herrenschmidt wrote:
> On Thu, 2013-04-18 at 12:45 +0800, Chen Gang wrote:
>> Hello Maintainers:
>>
>>
>> in arch/powerpc/kernel/lparcfg.c, parse_system_parameter_string()
>>
>>   need set '\0' for 'local_buffer'.
>>
>>   the reason is:
>>     SPLPAR_MAXLENGTH is 1026, RTAS_DATA_BUF_SIZE is 4096
>>     the contents of rtas_data_buf may truncated in memcpy (line 301).
>>
>>     if contents are truncated.
>>       the splpar_strlen is more than 1026 (line 321)
>>       the while loop checking will not find the end of buffer (line 326)
>>       it will cause memory access violation.
>>
>>
>>   I find it by reading code, so please help check.
> 
> And a signed-off-by please ?
> 

  ok, thanks, I should send the related patch.


-- 
Chen Gang

Asianux Corporation
