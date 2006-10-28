Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 4BCAB67CA7
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 16:42:01 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so752700ugc
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 23:42:00 -0700 (PDT)
Message-ID: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
Date: Sat, 28 Oct 2006 00:41:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Is get_property() correct?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is the implementation of get_property correct?  The comment says it
returns the value of a property; but the return statement just returns
the property pointer (cast as void*) it got from of_find_property();
not the value.

Does the comment or the code need to change?

in prom.c:

/*
 * Find a property with a given name for a given node
 * and return the value.
 */
const void *get_property(const struct device_node *np, const char *name,
                         int *lenp)
{
        struct property *pp = of_find_property(np,name,lenp);
        return pp ? pp->value : NULL;
}
EXPORT_SYMBOL(get_property);

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
