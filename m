Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC5B22C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 06:35:03 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 14:35:00 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BA413C9004A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 14:34:54 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VJYuHl4784628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 19:34:57 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VJYuGo026170
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 14:34:56 -0500
Received: from oc3347516403.ibm.com ([9.80.92.71])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s0VJYr2Q025932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 14:34:55 -0500
Date: Fri, 31 Jan 2014 13:34:53 -0600
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] Fix coding style errors
Message-ID: <20140131193451.GA23880@oc3347516403.ibm.com>
References: <1390878454-4329-1-git-send-email-stewartb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390878454-4329-1-git-send-email-stewartb2@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 27, 2014 at 09:07:34PM -0600, Brandon Stewart wrote:
> I corrected several coding errors.
> 
> Signed-off-by: Brandon Stewart <stewartb2@gmail.com>
> ---
>  drivers/macintosh/adb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index 53611de..dd3f49a 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -623,7 +623,7 @@ do_adb_query(struct adb_request *req)
>  {
>  	int	ret = -EINVAL;
> 
> -	switch(req->data[1]) {
> +	switch (req->data[1]) {
>  	case ADB_QUERY_GETDEVINFO:
>  		if (req->nbytes < 3)
>  			break;
> @@ -792,8 +792,9 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
>  	}
>  	/* Special case for ADB_BUSRESET request, all others are sent to
>  	   the controller */
> -	else if ((req->data[0] == ADB_PACKET) && (count > 1)
> -		&& (req->data[1] == ADB_BUSRESET)) {
> +	else if (req->data[0] == ADB_PACKET &&
> +		req->data[1] == ADB_BUSRESET &&
> +		count > 1) {

Is this re-ordering safe?  Isn't 'count > 1' notionally indicating whether
req->data[1] exists to be tested in the first place?

On the other hand there's a check at the top of the routine that returns 
if count < 2, so maybe the check here should be removed altogether (along
with one a few lines above)?
