Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FEA41A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 20:35:41 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3C501402A2
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 20:35:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 16:05:38 +0530
Message-ID: <559E4E60.4000107@linux.vnet.ibm.com>
Date: Thu, 09 Jul 2015 16:05:12 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
Subject: Re: ipmi/powernv: Fix a minor bug
References: <20150708104201.52B3D140AF3@ozlabs.org>
In-Reply-To: <20150708104201.52B3D140AF3@ozlabs.org>
Content-Type: multipart/alternative;
 boundary="------------090506070704010800000809"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090506070704010800000809
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 07/08/2015 04:12 PM, Michael Ellerman wrote:
> On Wed, 2015-08-07 at 06:27:28 UTC, Neelesh Gupta wrote:
>> If the OPAL call to receive the ipmi message fails, then we free up the smi
>> message before returning. But, the driver still holds the reference to old
>> smi message in the 'cur_msg' which is dangerous if the driver derefernces it
>> later and it will further block the subsequent ipmi operations.
> This doesn't sound like "a minor bug" ?
>
> What are the actual symptoms of the bug? Does it crash, always, sometimes? Does
> it actually "block the subsequent ipmi operations"?

In the normal scenario, it doesn't happen.
To create the crash, I passed error code in opal call 'opal_ipmi_recv()'
I think there is more need to be done than this change. So, I will resend
the next version addressing all of your concerns.

Thanks,
Neelesh.

>
> Even if this *is* a minor bug, please give it a proper subject that describes
> what it does.
>
> Also which commit introduced the bug?
>
> And finally you don't seem to have CC'ed the ipmi maintainers?
>
> cheers
>


--------------090506070704010800000809
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <small>Hi Michael,</small><br>
    <br>
    <div class="moz-cite-prefix">On 07/08/2015 04:12 PM, Michael
      Ellerman wrote:<br>
    </div>
    <blockquote cite="mid:20150708104201.52B3D140AF3@ozlabs.org"
      type="cite">
      <pre wrap="">On Wed, 2015-08-07 at 06:27:28 UTC, Neelesh Gupta wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">If the OPAL call to receive the ipmi message fails, then we free up the smi
message before returning. But, the driver still holds the reference to old
smi message in the 'cur_msg' which is dangerous if the driver derefernces it
later and it will further block the subsequent ipmi operations. 
</pre>
      </blockquote>
      <pre wrap="">
This doesn't sound like "a minor bug" ?

What are the actual symptoms of the bug? Does it crash, always, sometimes? Does
it actually "block the subsequent ipmi operations"?</pre>
    </blockquote>
    <br>
    <small>In the normal scenario, it doesn't happen.<br>
      To create the crash, I passed error code in opal call
      'opal_ipmi_recv()'<br>
      I think there is more need to be done than this change. So, I will
      resend<br>
      the next version addressing all of your concerns.<br>
      <br>
      Thanks,<br>
      Neelesh.<br>
    </small><br>
    <blockquote cite="mid:20150708104201.52B3D140AF3@ozlabs.org"
      type="cite">
      <pre wrap="">

Even if this *is* a minor bug, please give it a proper subject that describes
what it does.

Also which commit introduced the bug?

And finally you don't seem to have CC'ed the ipmi maintainers?

cheers

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090506070704010800000809--
