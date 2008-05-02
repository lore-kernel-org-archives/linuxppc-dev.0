Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 203F6DDE06
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 05:55:07 +1000 (EST)
Received: from [192.168.1.37] (node229.79.251.72.1dial.com [72.251.79.229])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m42JshHh072270
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 12:55:01 -0700 (PDT)
Message-ID: <481B7CB4.90103@hypersurf.com>
Date: Fri, 02 May 2008 13:42:28 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: function calls from identify_cpu()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I added:

int __init iDoNothingUseful(struct cpu_spec *s,struct cpu_spec *t)
{
         return s-t;
}

right before the definition of identify_cpu() in cputable.c and:

//                      (void) (*PTRRELOC(&iDoNothingUseful))(s,t);
                         (void) iDoNothingUseful(s,t);

right before the return s; in the match block and it will not boot? Can 
someone please explain what might be going on?

Thanks!

kevin
