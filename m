Return-Path: <adlai@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F2332C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 06:32:12 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@us.ibm.com>;
 Thu, 9 Aug 2012 16:32:09 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BF11238C8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 16:32:06 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q79KW46e146534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2012 16:32:05 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q79KVQo6001555
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2012 14:31:26 -0600
In-Reply-To: <20120809155750.GA7352@linux.vnet.ibm.com>
References: <1344367748.24990.1.camel@footlong>
 <1344369479.24990.9.camel@footlong>
 <20120809155750.GA7352@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] drivers/char/tpm: Add securityfs support for event log
To: Kent Yoder <key@linux.vnet.ibm.com>
Message-ID: <OF284CDC52.FE42D0E6-ON87257A55.007076F8-86257A55.0070EDBB@us.ibm.com>
From: Ashley D Lai <adlai@us.ibm.com>
Date: Thu, 9 Aug 2012 15:31:25 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=08BBF0C6DFE3F0688f9e8a93df938690918c08BBF0C6DFE3F068"
Cc: linux-kernel@vger.kernel.org, Ashley Lai <adlai@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=08BBF0C6DFE3F0688f9e8a93df938690918c08BBF0C6DFE3F068
Content-type: text/plain; charset=US-ASCII

Hi Kent,

> > +ifdef CONFIG_TCG_IBMVTPM
> > +   tpm_bios-objs += tpm_eventlog.o tpm_of.o
> > +else
> > +   tpm_bios-objs += tpm_eventlog.o tpm_noeventlog.o
>
>   tpm_eventlog.c is included in all cases here...
>

> > +static inline struct dentry **tpm_bios_log_setup(char *name)
> > +{
> > +   return NULL;
> > +}
> > +static inline void tpm_bios_log_teardown(struct dentry **dir)
> > +{
> > +}
> > +#endif
>
>   But here, without acpi or ppc64, we compile in stubs, which breaks
> things. It looks like we don't need these stubs at all anymore, and can
> rely on TPM_NO_EVENT_LOG to bail out in the cases on x86 where ACPI is
> disabled.
>
> Kent

Thanks for testing it out.  I will fix it in the next version.

--Ashley
--0__=08BBF0C6DFE3F0688f9e8a93df938690918c08BBF0C6DFE3F068
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Hi Kent,</tt><br>
<tt><br>
&gt; &gt; +ifdef CONFIG_TCG_IBMVTPM<br>
&gt; &gt; + &nbsp; tpm_bios-objs += tpm_eventlog.o tpm_of.o<br>
&gt; &gt; +else<br>
&gt; &gt; + &nbsp; tpm_bios-objs += tpm_eventlog.o tpm_noeventlog.o<br>
&gt; <br>
&gt; &nbsp; tpm_eventlog.c is included in all cases here...<br>
&gt; <br>
<br>
&gt; &gt; +static inline struct dentry **tpm_bios_log_setup(char *name)<br>
&gt; &gt; +{<br>
&gt; &gt; + &nbsp; return NULL;<br>
&gt; &gt; +}<br>
&gt; &gt; +static inline void tpm_bios_log_teardown(struct dentry **dir)<br>
&gt; &gt; +{<br>
&gt; &gt; +}<br>
&gt; &gt; +#endif<br>
&gt; <br>
&gt; &nbsp; But here, without acpi or ppc64, we compile in stubs, which breaks<br>
&gt; things. It looks like we don't need these stubs at all anymore, and can<br>
&gt; rely on TPM_NO_EVENT_LOG to bail out in the cases on x86 where ACPI is<br>
&gt; disabled.<br>
&gt; <br>
&gt; Kent</tt><br>
<br>
<tt>Thanks for testing it out. &nbsp;I will fix it in the next version.</tt><br>
<br>
<tt>--Ashley</tt></body></html>
--0__=08BBF0C6DFE3F0688f9e8a93df938690918c08BBF0C6DFE3F068--
