Return-Path: <linasvepstas@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id D1F7EDE44A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 06:22:53 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so1546087ywj.39
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 13:22:42 -0700 (PDT)
Message-ID: <3ae3aa420804161322i10e5efe2v2f74e1f9d6698e90@mail.gmail.com>
Date: Wed, 16 Apr 2008 15:22:42 -0500
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Manish Ahuja" <ahuja@austin.ibm.com>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
In-Reply-To: <47FAB221.7050406@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <47FAB221.7050406@austin.ibm.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07/04/2008, Manish Ahuja <ahuja@austin.ibm.com> wrote:
> A small proposed change in the amount of reserve space we allocate during boot.
>  Currently we reserve 256MB only.
>  The proposed change does one of the 3 things.
>
>  A. It checks to see if there is cmdline variable set and if found sets the
>    value to it. OR
>  B. It computes 5% of total ram and rounds it down to multiples of 256MB. AND
>  C. Compares the rounded down value and returns larger of two values, the new
>    computed value or 256MB.
>
>  Again this is for large systems who have excess memory.
>
[...]
>   early_param("phyp_dump", early_phyp_dump_enabled);

I'm pretty sure you will want to document this boot param in the documentation,
as well as add a few words about why it might be interesting to users (i.e.
that its for large systems...)

--linas
