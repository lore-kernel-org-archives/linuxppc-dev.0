Return-Path: <penberg@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id DB2FD67BBC
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 04:42:28 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1362626ugc
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 11:42:25 -0700 (PDT)
Message-ID: <84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
Date: Tue, 24 Oct 2006 21:42:06 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
In-Reply-To: <20061024160406.923275000@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061024160140.452484000@arndb.de>
	<20061024160406.923275000@arndb.de>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

On 10/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
>         spu_acquire(ctx);
> -       for (count = 0; count <= len; count += 4, udata++) {
> +       for (count = 0; (count + 4) <= len; count += 4, udata++) {

Wouldn't this be more obvious as

  for (count = 0, count < (len / 4); count++, udata++) {

And then do count * 4 if you need the actual index somewhere. Hmm?
