Return-Path: <michaelellerman@internode.on.net>
Received: from mail.internode.on.net (bld-mail01.adl2.internode.on.net
	[203.16.214.65]) by ozlabs.org (Postfix) with ESMTP id 446B467A5D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 19:36:58 +1000 (EST)
Subject: Re: [Fastboot] [PATCH]ppc64 kexec tools rm platform fix
From: Michael Ellerman <michaelellerman@internode.on.net>
To: David Wilder <dwilder@us.ibm.com>
In-Reply-To: <1144659236.26317.35.camel@localhost.localdomain>
References: <443700CB.3090909@us.ibm.com>
	<1144659236.26317.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 11:36:49 +0200
Message-Id: <1144748209.25733.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Mohan Kumar <mohankumar@in.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Wilder wrote:
> I lost Michael's reply on the list.
> Here it is with my response..
> 
> Michael wrote:
> 
> >/ -                               continue;
> />/ -                       }
> />/                         memset(fname, 0, sizeof(fname));
> />/                         strcpy(fname, device_tree);
> />/                         strcat(fname, dentry->d_name);
> />/                         strcat(fname, "/linux,htab-base");
> />/                         if ((file = fopen(fname, "r")) == NULL) {
> />/ -                               perror(fname);
> />/                                 closedir(cdir);
> />/ +                               if (errno == ENOENT) {
> />/ +                                       /* Non LPAR */
> />/ +                                       errno = 0;
> />/ +                                       continue;
> />/ +                                }
> />/ +                               perror(fname);
> />/                                 closedir(dir);
> />/                                 return -1;
> /
> I don't think you want to do the closedir() before the if. You
> certainly
> don't need to do it twice?
> 
> The two closedir() calls are not closing the same thing.

Right. We don't seem to close cdir if it all works though. That code
needs some serious restructuring, 350+ line functions are not cool.

cheers

-- 
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
