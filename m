Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C22E01A181D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:52:11 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9635B140129
 for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2015 18:52:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 29 May 2015 18:52:11 +1000
Message-ID: <55682885.9090109@linux.vnet.ibm.com>
Date: Fri, 29 May 2015 14:21:17 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>, Cyril Bur <cyrilbur@gmail.com>,
 linuxppc-dev@ozlabs.org
CC: Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH V2] drivers/mtd: add powernv flash MTD abstraction driver
References: <1432818408-11558-1-git-send-email-cyrilbur@gmail.com>
 <55674F90.8040903@linux.vnet.ibm.com> <556814FE.9000305@fr.ibm.com>
In-Reply-To: <556814FE.9000305@fr.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------050804030905060906040007"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050804030905060906040007
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/29/2015 12:57 PM, Cedric Le Goater wrote:
> Hello,
>
> On 05/28/2015 07:25 PM, Neelesh Gupta wrote:
>>
>> On 05/28/2015 06:36 PM, Cyril Bur wrote:
>> +
>> +	rc = opal_async_wait_response(token, &msg);
>> +	opal_async_release_token(token);
>> +	if (rc) {
>> +		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
>> +		return -EIO;
>> +	}
>> +
>> +	rc = be64_to_cpu(msg.params[1]);
>> +	if (rc == OPAL_SUCCESS) {
>> +		rc = 0;
>> +		if (retlen)
>> +			*retlen = len;
>> +	} else {
>> +		rc = -EIO;
>> +	}
>> +
>>
>> return rc;
> You could use opal_error_code() to convert opal codes in errnos.
>
> Also, powernv_flash_async_op() only contains low level OPAL cookery. I think
> the code would be better placed under 'arch/powerpc/platforms/powernv/' ?

The logic would unnecessary be split between the platform and driver, it 
would make
sense if the method is going to change across the platforms, but that's 
not the case.
Moreover, we will still have to export the symbol to make this work as a 
module ...

Neelesh.

>
> Cheers,
>
> C.
>
>


--------------050804030905060906040007
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 05/29/2015 12:57 PM, Cedric Le
      Goater wrote:<br>
    </div>
    <blockquote cite="mid:556814FE.9000305@fr.ibm.com" type="cite">
      <pre wrap="">Hello, 

On 05/28/2015 07:25 PM, Neelesh Gupta wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">

On 05/28/2015 06:36 PM, Cyril Bur wrote:
</pre>
        <pre wrap="">
+
+	rc = opal_async_wait_response(token, &amp;msg);
+	opal_async_release_token(token);
+	if (rc) {
+		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
+		return -EIO;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc == OPAL_SUCCESS) {
+		rc = 0;
+		if (retlen)
+			*retlen = len;
+	} else {
+		rc = -EIO;
+	}
+
</pre>
        <pre wrap="">

return rc;
</pre>
      </blockquote>
      <pre wrap="">
You could use opal_error_code() to convert opal codes in errnos.

Also, powernv_flash_async_op() only contains low level OPAL cookery. I think 
the code would be better placed under 'arch/powerpc/platforms/powernv/' ?</pre>
    </blockquote>
    <br>
    <small>The logic would unnecessary be split between the platform and
      driver, it would make<br>
      sense if the method is going to change across the platforms, but
      that's not the case.<br>
      Moreover, we will still have to export the symbol to make this
      work as a module ...<br>
      <br>
      Neelesh.<br>
    </small><br>
    <blockquote cite="mid:556814FE.9000305@fr.ibm.com" type="cite">
      <pre wrap="">

Cheers,

C.

</pre>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------050804030905060906040007--
