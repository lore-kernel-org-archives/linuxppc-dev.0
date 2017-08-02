Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN0s75zTwzDqpX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 03:43:05 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72HfLJE130131
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 13:43:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3e4vs4rn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 13:43:02 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 11:43:01 -0600
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72HgwUi65405052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 10:42:59 -0700
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72Egv8M023198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 11:42:58 -0300
References: <20170706221753.17380-1-bauerman@linux.vnet.ibm.com>
 <20170706221753.17380-8-bauerman@linux.vnet.ibm.com>
 <1501424988.9230.67.camel@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 7/7] ima: Support module-style appended signatures for
 appraisal
In-reply-to: <1501424988.9230.67.camel@linux.vnet.ibm.com>
Date: Wed, 02 Aug 2017 14:42:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fud9yig8.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Thu, 2017-07-06 at 19:17 -0300, Thiago Jung Bauermann wrote:
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -200,18 +200,40 @@ int ima_read_xattr(struct dentry *dentry,
>>   */
>>  int ima_appraise_measurement(enum ima_hooks func,
>>  			     struct integrity_iint_cache *iint,
>> -			     struct file *file, const unsigned char *filename,
>> -			     struct evm_ima_xattr_data *xattr_value,
>> -			     int xattr_len, int opened)
>> +			     struct file *file, const void *buf, loff_t size,
>> +			     const unsigned char *filename,
>> +			     struct evm_ima_xattr_data **xattr_value_,
>> +			     int *xattr_len_, int opened)
>>  {
>>  	static const char op[] = "appraise_data";
>>  	char *cause = "unknown";
>>  	struct dentry *dentry = file_dentry(file);
>>  	struct inode *inode = d_backing_inode(dentry);
>>  	enum integrity_status status = INTEGRITY_UNKNOWN;
>> -	int rc = xattr_len, hash_start = 0;
>> +	struct evm_ima_xattr_data *xattr_value = *xattr_value_;
>> +	int xattr_len = *xattr_len_, rc = xattr_len, hash_start = 0;
>> +	bool appraising_modsig = false;
>> +	void *xattr_value_evm;
>> +	size_t xattr_len_evm;
>> +
>> +	if (iint->flags & IMA_MODSIG_ALLOWED) {
>> +		/*
>> +		 * Not supposed to happen. Hooks that support modsig are
>> +		 * whitelisted when parsing the policy using
>> +		 * ima_hooks_supports_modsig.
>> +		 */
>> +		if (!buf || !size)
>> +			WARN_ONCE(true, "%s doesn't support modsig\n",
>> +				  func_tokens[func]);
>
> ima _appraise_measurement() is getting kind of long. Is there any
> reason we can't move this comment and test to ima_read_modsig()?

I didn't do that because then I would need to pass func as an argument
to ima_read_modsig just to print the warning above. But it does simplify
the code so it may be worth it. I'll make that change in v4.

>> @@ -229,8 +251,24 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  		goto out;
>>  	}
>> 
>> -	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
>> -	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
>> +	/*
>> +	 * Appended signatures aren't protected by EVM but we still call
>> +	 * evm_verifyxattr to check other security xattrs, if they exist.
>> +	 */
>> +	if (appraising_modsig) {
>> +		xattr_value_evm = NULL;
>> +		xattr_len_evm = 0;
>> +	} else {
>> +		xattr_value_evm = xattr_value;
>> +		xattr_len_evm = xattr_len;
>> +	}
>> +
>> +	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value_evm,
>> +				 xattr_len_evm, iint);
>> +	if (appraising_modsig && status == INTEGRITY_FAIL) {
>> +		cause = "invalid-HMAC";
>> +		goto out;
>
> "modsig" is special, because having any security xattrs is not
> required. This test doesn't prevent status from being set to
> "missing-HMAC". This test is redundant with the original tests below.

Indeed, that is wrong. I'm still a bit fuzzy about how EVM works and how
it interacts with IMA. The only way I can think of singling out modsig
without reintroduced the complex expression you didn't like in v2 is as
below. What do you think?

@@ -229,8 +241,25 @@ int ima_appraise_measurement(enum ima_hooks func,
 		goto out;
 	}
 
-	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
+	/*
+	 * Appended signatures aren't protected by EVM but we still call
+	 * evm_verifyxattr to check other security xattrs, if they exist.
+	 */
+	if (appraising_modsig) {
+		xattr_value_evm = NULL;
+		xattr_len_evm = 0;
+	} else {
+		xattr_value_evm = xattr_value;
+		xattr_len_evm = xattr_len;
+	}
+
+	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value_evm,
+				 xattr_len_evm, iint);
+	if (appraising_modsig && (status == INTEGRITY_NOLABEL
+				  || status == INTEGRITY_NOXATTRS))
+		/* It's ok if there's no xattr in the case of modsig. */
+		;
+	else if (status != INTEGRITY_PASS && status != INTEGRITY_UNKNOWN) {
 		if ((status == INTEGRITY_NOLABEL)
 		    || (status == INTEGRITY_NOXATTRS))
 			cause = "missing-HMAC";

>> +	} else if (status != INTEGRITY_PASS && status != INTEGRITY_UNKNOWN) {
>>  		if ((status == INTEGRITY_NOLABEL)
>>  		    || (status == INTEGRITY_NOXATTRS))
>>  			cause = "missing-HMAC";
>> @@ -281,6 +319,43 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  			status = INTEGRITY_PASS;
>>  		}
>
> Calling evm_verifyxattr() with the IMA xattr value prevents EVM from
> having to re-read the IMA xattr, but isn't necessary.On modsig
> signature verification failure, calling evm_verifyxattr() a second
> time isn't necessary.

So even for the IMA xattr sig case, the evm_verifyxattr call in
ima_appraise_measurement is an optimization and can be skipped?

>> +	case IMA_MODSIG:
>> +		/*
>> +		 * To avoid being tricked into recursion, we don't allow a
>> +		 * modsig stored in the xattr.
>> +		 */
>> +		if (!appraising_modsig) {
>> +			status = INTEGRITY_UNKNOWN;
>> +			cause = "unknown-ima-data";
>> +
>> +			break;
>> +		}
>> +
>> +		rc = ima_modsig_verify(INTEGRITY_KEYRING_IMA, xattr_value);
>> +		if (!rc) {
>> +			iint->flags |= IMA_DIGSIG;
>> +			status = 
>> +
>> +			kfree(*xattr_value_);
>> +			*xattr_value_ = xattr_value;
>> +			*xattr_len_ = xattr_len;
>> +
>> +			break;
>> +		}
>
> When including the appended signature in the measurement list, the
> corresponding file hash needs to be included in the measurement list,
> which might be different than the previously calculated file hash
> based on the hash algorithm as defined in the IMA xattr.
>
> Including the file hash and signature in the measurement list allows
> the attestation server, with just a public key, to verify the file
> signature against the file hash. No need for a white list.
>
> ima_modsig_verify() must calculate the file hash in order to verify
> the file signature. This file hash value somehow needs to be returned
> in order for it to be included in the measurement list.

In that case, patch 6/7 "ima: Store measurement after appraisal" isn't
enough and we have to go back to v2's change in ima_main.c which ties
together the collect and appraise steps in process_measurement (In that
version I called the function measure_and_appraise but it should be
called collect_and_appraise instead). That is because if the modsig
verification fails, the hash needs to be recalculated for the xattr
signature verification.

Either that, or I add another call to ima_collect_measurement inside
ima_appraise_measurement if the modsig verification fails. Which do you
prefer?

>> +		/*
>> +		 * The appended signature failed verification. Let's try
>> +		 * reading a signature from the extended attribute instead.
>> +		 */
>> +
>> +		pr_debug("modsig didn't verify, trying the xattr signature\n");
>> +
>> +		ima_free_xattr_data(xattr_value);
>> +		iint->flags &= ~IMA_MODSIG_ALLOWED;
>> +
>> +		return ima_appraise_measurement(func, iint, file, buf, size,
>> +						filename, xattr_value_,
>> +						xattr_len_, opened);
>
> Most of the code before "switch" needs to be done only once. Is
> recursion necessary? Or can we just retry the "switch" using the IMA
> xattr, assuming there is an IMA xattr?

I used recursion to avoid duplicating two blocks of code: the logic in
the "if (rc <= 0)" block which needs to be done again when verifying the
xattr sig, and also the logic of interpreting the return value of
evm_verifyxattr which I also thought needed to be done again, but you
seem to be saying that is just an optimization and can be skipped.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
